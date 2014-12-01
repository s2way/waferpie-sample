Testing = require('waferpie').Testing
path = require 'path'
expect = require 'expect.js'

describe 'Recipes', ->

    testing = null

    beforeEach ->
        testing = new Testing path.join(__dirname, '../../../kitchen-coffee/'), currentDataSource: 'MySQL'

    describe 'get', ->

        it 'should return all recipes if no parameter is passed', (done) ->
            results = []
            mock =
                init: -> return
                mocked: true
                query: (query, callback) ->
                    callback(null, [])
                findAll: (params) ->
                    params.callback(null, results)

            testing.mockModel 'MySQL.Recipe', mock

            testing.callController 'Recipes', 'get', {}, (body, info) ->
                expect(body.count).to.be 0
                expect(body.data).to.be results
                expect(info.statusCode).to.be 200
                done()

        it 'should return a single ingredient if the id is supplied', (done) ->
            result = {}
            mock =
                init: -> return
                query: (query, params, callback) ->
                    callback(null, [])
                findById: (id, callback) ->
                    expect(id).to.be '1'
                    callback(null, result)

            testing.mockModel 'MySQL.Recipe', mock

            testing.callController 'Recipes', 'get', segments: ['1'], (body, info) ->
                expect(body).to.be result
                expect(info.statusCode).to.be 200
                done()

        it 'should return 404 if the id was supplied and the record was not found', (done) ->
            mock =
                init: -> return
                findById: (id, callback) ->
                    callback(null, null)

            testing.mockModel 'MySQL.Recipe', mock
            testing.callController 'Recipes', 'get', segments: ['1'], (body, info) ->
                expect(body).to.be.ok()
                expect(info.statusCode).to.be 404
                done()

    describe 'put', ->

        record = name: 'Tomato'

        it 'should update an ingredient by id if the record was found', (done) ->
            mock =
                init: -> return
                findById: (id, callback) ->
                    callback(null, record)
                save: (params) ->
                    expect(params.data.id).to.be 1
                    expect(params.data.name).to.be 'Tomato'
                    params.callback(null, record)

            testing.mockModel 'MySQL.Recipe', mock
            testing.callController 'Recipes', 'put',
                segments: ['1']
                payload: record
            , (body, info) ->
                expect(body.id).to.be 1
                expect(body.name).to.be 'Tomato'
                expect(info.statusCode).to.be 200
                done()

        it 'should return 404 if the resource was not found', (done) ->
            mock =
                init: -> return
                findById: (id, callback) ->
                    callback(null, null)

            testing.mockModel 'MySQL.Recipe', mock
            testing.callController 'Recipes', 'put',
                segments: ['1']
                payload: record
            , (body, info) ->
                expect(body).to.be.ok()
                expect(info.statusCode).to.be 404
                done()

        it 'should return 404 if the id is not valid', (done) ->
            testing.mockModel 'MySQL.Recipe', init: -> return
            testing.callController 'Recipes', 'put',
                segments: ['not a number!']
                payload: record
            , (body, info) ->
                expect(body.error).to.be.ok()
                expect(info.statusCode).to.be 400
                done()

        it 'should save an recipe/ingredient if the ingredient id is passed after the id', (done) ->
            record =
                quantity: 3
            mock =
                init: -> return
                save: (params) ->
                    expect(params.data).to.eql
                        recipe_id: 1
                        ingredient_id: 2
                        quantity: 3
                    params.callback(null, {})

            options =
                payload: record
                segments: ['1', '2']

            testing.mockModel 'MySQL.RecipeIngredient', mock
            testing.mockModel 'MySQL.Ingredient',
                init: ->
                findById: (id, callback) -> callback null, {}
            testing.mockModel 'MySQL.Recipe',
                init: ->
                findById: (id, callback) ->
                    callback null, {}


            testing.callController 'Recipes', 'put', options, (body, info) ->
                expect(body).to.be.ok()
                expect(info.statusCode).to.be 201
                done()

    describe 'post', ->

        it 'should create a new ingredient it the validation passes', (done) ->
            record =
                name: 'Tomato'
            mock =
                init: -> return
                save: (params) ->
                    expect(params.data).to.be record
                    params.callback(null, {})

            testing.mockModel 'MySQL.Recipe', mock

            testing.callController 'Recipes', 'post', payload: record, (body, info) ->
                expect(body).to.be.ok()
                expect(info.statusCode).to.be 201
                done()


    describe 'delete', ->

        it 'should remove an ingredient by id if the it is supplied', (done) ->
            mock =
                init: -> return
                removeById: (id, callback) ->
                    expect(id).to.be '1'
                    callback(null, {})

            testing.mockModel 'MySQL.Recipe', mock

            testing.callController 'Recipes', 'delete', segments: ['1'], (body, info) ->
                expect(body).to.be.ok()
                expect(info.statusCode).to.be 200
                done()

        it 'should all recipes if /all is passed', (done) ->
            mock =
                init: -> return
                removeAll: (callback) ->
                    callback(null)

            testing.mockModel 'MySQL.Recipe', mock

            testing.callController 'Recipes', 'delete', segments: ['all'], (body, info) ->
                expect(body).to.be.ok()
                expect(info.statusCode).to.be 200
                done()


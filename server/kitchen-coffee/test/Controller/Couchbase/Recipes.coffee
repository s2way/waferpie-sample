Testing = require('waferpie').Testing
path = require 'path'
expect = require 'expect.js'

describe 'Recipes', ->

    testing = null

    beforeEach ->
        testing = new Testing path.join(__dirname, '../../../../kitchen-coffee/')

    describe 'get', ->

        it 'should return all recipes if no parameter is passed', (done) ->
            results = []
            mock =
                init: -> return
                mocked: true
                query: (query, callback) ->
                    callback(null, [])
                findAll: (params, callback) ->
                    callback(null, results)

            testing.mockModel 'Couchbase.Recipe', mock

            testing.callController 'Couchbase.Recipes', 'get', {}, (body, info) ->
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

            testing.mockModel 'Couchbase.Recipe', mock

            testing.callController 'Couchbase.Recipes', 'get', segments: ['1'], (body, info) ->
                expect(body).to.be result
                expect(info.statusCode).to.be 200
                done()

        it 'should return 404 if the id was supplied and the record was not found', (done) ->
            mock =
                init: -> return
                findById: (id, callback) ->
                    callback(null, null)

            testing.mockModel 'Couchbase.Recipe', mock
            testing.callController 'Couchbase.Recipes', 'get', segments: ['1'], (body, info) ->
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
                save: (params, callback) ->
                    expect(params.data.id).to.be 1
                    expect(params.data.name).to.be 'Tomato'
                    callback(null, record)

            testing.mockModel 'Couchbase.Recipe', mock
            testing.callController 'Couchbase.Recipes', 'put',
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

            testing.mockModel 'Couchbase.Recipe', mock
            testing.callController 'Couchbase.Recipes', 'put',
                segments: ['1']
                payload: record
            , (body, info) ->
                expect(body).to.be.ok()
                expect(info.statusCode).to.be 404
                done()

        it 'should return 404 if the id is not valid', (done) ->
            testing.mockModel 'Couchbase.Recipe', init: -> return
            testing.callController 'Couchbase.Recipes', 'put',
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
                save: (params, callback) ->
                    expect(params.data).to.eql
                        recipe_id: 1
                        ingredient_id: 2
                        quantity: 3
                    callback(null, {})

            options =
                payload: record
                segments: ['1', '2']

            testing.mockModel 'Couchbase.RecipeIngredient', mock
            testing.mockModel 'Couchbase.Ingredient',
                init: ->
                findById: (id, callback) -> callback null, {}
            testing.mockModel 'Couchbase.Recipe',
                init: ->
                findById: (id, callback) ->
                    callback null, {}


            testing.callController 'Couchbase.Recipes', 'put', options, (body, info) ->
                expect(body).to.be.ok()
                expect(info.statusCode).to.be 201
                done()

    describe 'post', ->

        it 'should create a new ingredient it the validation passes', (done) ->
            record =
                name: 'Tomato'
            mock =
                init: -> return
                save: (params, callback) ->
                    expect(params.data).to.be record
                    callback(null, {})

            testing.mockModel 'Couchbase.Recipe', mock

            testing.callController 'Couchbase.Recipes', 'post', payload: record, (body, info) ->
                expect(body).to.be.ok()
                expect(info.statusCode).to.be 201
                done()


    describe 'delete', ->

        it 'should remove an ingredient by id if the it is supplied', (done) ->
            mock =
                init: -> return
                removeById: (params, callback) ->
                    expect(params.id).to.be '1'
                    callback(null, {})

            testing.mockModel 'Couchbase.Recipe', mock
            testing.callController 'Couchbase.Recipes', 'delete', segments: ['1'], (body, info) ->
                expect(body).to.be.ok()
                expect(info.statusCode).to.be 200
                done()

        it 'should all recipes if /all is passed', (done) ->
            mock =
                init: -> return
                removeAll: (callback) ->
                    callback(null)

            testing.mockModel 'Couchbase.Recipe', mock

            testing.callController 'Couchbase.Recipes', 'delete', segments: ['all'], (body, info) ->
                expect(body).to.be.ok()
                expect(info.statusCode).to.be 200
                done()


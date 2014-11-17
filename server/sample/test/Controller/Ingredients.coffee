Testing = require('waferpie').Testing
path = require 'path'
expect = require 'expect.js'

describe 'Ingredients', ->

    testing = null

    beforeEach ->
        testing = new Testing path.join(__dirname, '../../../sample/'), currentDataSource: 'MySQL'

    describe 'get', ->

        it 'should return all ingredients if no parameter is passed', (done) ->
            results = []
            mock =
                init: -> return
                mocked: true
                findAll: (params) ->
                    params.callback(null, results)

            testing.mockModel 'MySQL.Ingredient', mock

            testing.callController 'Ingredients', 'get', {}, (body, info) ->
                expect(body.count).to.be 0
                expect(body.data).to.be results
                expect(info.statusCode).to.be 200
                done()

        it 'should return a single ingredient if the id is supplied', (done) ->
            result = {}
            mock =
                init: -> return
                findById: (id, callback) ->
                    expect(id).to.be '1'
                    callback(null, result)

            testing.mockModel 'MySQL.Ingredient', mock

            testing.callController 'Ingredients', 'get', segments: ['1'], (body, info) ->
                expect(body).to.be result
                expect(info.statusCode).to.be 200
                done()

    describe 'put', ->

        it 'should update an ingredient'

    describe 'post', ->

        it 'should create a new ingredient'

    describe 'delete', ->

        it 'should remove an ingredient by id'


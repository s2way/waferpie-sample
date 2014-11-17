Testing = require('waferpie').Testing
path = require 'path'
expect = require 'expect.js'

describe 'Ingredients', ->

    testing = null

    beforeEach ->
        testing = new Testing path.join(__dirname, '../../../sample/')

    describe 'get', ->

        it 'should return all ingredients if no parameter is passed', (done) ->
            results = {}
            testing.mockModel 'MySQL.Ingredient',
                init: -> return
                findAll: (callback) ->
                    callback(null, results)
            testing.callController 'Ingredients', 'get', {}, (body, info) ->
                expect(body).to.be results
                expect(info.statusCode).to.be 200
                done()

        it 'should return a single ingredient if the id is supplied', (done) ->
            try
                result = {}
                testing.mockModel 'MySQL.Ingredient',
                    init: -> return
                    findByKey: (id, callback) ->
                        expect(id).to.be '1'
                        callback(null, result)
                testing.callController 'Ingredients', 'get', segments: ['1'], (body, info) ->
                    expect(body).to.be result
                    expect(info.statusCode).to.be 200
                    done()
            catch e
                console.log e, e.stack

    describe 'put', ->

        it 'should update an ingredient'

    describe 'post', ->

        it 'should create a new ingredient'

    describe 'delete', ->

        it 'should remove an ingredient by id'


expect = require 'expect.js'
Testing = require('waferpie').Testing
path = require 'path'

describe 'Ingredient', ->

    describe 'save()', ->

        testing = null
        ingredient = null

        beforeEach ->

            testing = new Testing path.resolve path.join __dirname, '../../../'
            testing.mockComponent 'DataSource.MySQL', init: -> return
            ingredient = testing.createModel 'MySQL.Ingredient'
            ingredient.init()

        it 'should not save the ingredient if the validation does not pass', (done) ->
            ingredient.save
                data: {}
                callback: (error, result) ->
                    expect(error.name).to.be 'ValidationFailed'
                    expect(error.fields).to.eql
                        name:
                            notEmpty:
                                required: true
                            maxLength:
                                params: [30]
                                required: true
                    expect(result).not.to.be.ok()
                    done()
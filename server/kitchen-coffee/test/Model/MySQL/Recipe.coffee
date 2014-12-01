expect = require 'expect.js'
Testing = require('waferpie').Testing
path = require 'path'

describe 'Recipe', ->

    describe 'save()', ->

        testing = null
        recipe = null

        beforeEach ->

            testing = new Testing path.resolve path.join __dirname, '../../../'
            testing.mockComponent 'DataSource.MySQL', init: -> return
            recipe = testing.createModel 'MySQL.Recipe'
            recipe.init()

        it 'should not save the recipe if the validation does not pass', (done) ->
            recipe.save
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



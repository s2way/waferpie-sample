expect = require 'expect.js'
Testing = require('waferpie').Testing
path = require 'path'

describe 'RecipeIngredient', ->

    describe 'save()', ->

        testing = null
        recipe = null

        beforeEach ->

            testing = new Testing path.resolve path.join __dirname, '../../../'
            testing.mockComponent 'DataSource.MySQL', init: -> return
            recipe = testing.createModel 'MySQL.RecipeIngredient'
            recipe.init()

        it 'should not save the recipe/ingredient if the validation does not pass', (done) ->
            recipe.save
                data: {}
                callback: (error, result) ->
                    expect(error.name).to.be 'ValidationFailed'
                    expect(error.fields).to.eql
                        recipe_id:
                            isNumber: required: true
                        ingredient_id:
                            isNumber: required: true
                        quantity:
                            min: params: [1], required: true
                            max: params: [1000], required: true
                    expect(result).not.to.be.ok()
                    done()
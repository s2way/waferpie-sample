expect = require 'expect.js'
Testing = require('waferpie').Testing
path = require 'path'

describe 'Recipe', ->

    testing = null
    recipe = null

    beforeEach ->

        testing = new Testing path.resolve path.join __dirname, '../../../'

    describe 'save()', ->

        beforeEach ->
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

    describe 'findAllWithIngredients()', ->

        it 'should return the recipes with its associated ingredients', (done) ->
            recipes = [
                {id: '1', name: 'Lasagna', description: 'A lasagna'}
                {id: '2', name: 'Orange Juice', description: 'An orange juice'}
            ]
            recipeIngredients = [
                {id: '1', name: 'Tomato', quantity: '1', recipe_id: '1'}
                {id: '2', name: 'Orange', quantity: '4', recipe_id: '2'}
            ]


            testing.mockComponent 'DataSource.MySQL',
                init: -> return
                query: (query, params, dataSourceNameOrCallback, callback) ->
                    callback = dataSourceNameOrCallback if typeof dataSourceNameOrCallback is 'function'
                    callback = params if typeof params is 'function'

                    if query.indexOf('FROM recipe_ingredient') isnt -1
                        callback(null, recipeIngredients)
                    else
                        callback(null, recipes)

            recipe = testing.createModel 'MySQL.Recipe'
            recipe.init()

            recipe.findAllWithIngredients((error, results) ->
                expect(error).not.to.be.ok()
                expect(results[0].ingredients).to.be.an('object')
                expect(results[1].ingredients).to.be.an('object')
                done()
            )


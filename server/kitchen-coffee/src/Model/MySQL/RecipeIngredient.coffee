class RecipeIngredient
    constructor: ->
        return
    init: ->
        @_ninja = @component 'Database.MyNinja',
            dataSourceName: 'MySQL'
            validate:
                id: {}
                recipe_id:
                    isNumber:
                        required: true
                ingredient_id:
                    isNumber:
                        required: true
                unique: (value, fields, callback) =>
                    $ = @_ninja.$
                    recipeId = fields['recipe_id']
                    ingredientId = fields['ingredient_id']

                    return callback() if !recipeId or !ingredientId

                    @find(
                        conditions: $.and(
                            $.equal('recipe_id', recipeId)
                            $.equal('ingredient_id', ingredientId)
                        )
                        callback: (error, result) ->
                            return callback(error) if error
                            return callback() unless result
                            callback(message: 'This ingredient is already tied to this recipe')
                    )

                quantity:
                    min: params: [1], required: true
                    max: params: [1000], required: true

            table: 'recipe_ingredient'
        @_ninja.bind(@)

module.exports = RecipeIngredient
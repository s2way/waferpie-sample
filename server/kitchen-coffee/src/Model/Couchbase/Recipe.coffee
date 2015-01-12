class Recipe
    constructor: ->
        return
    init: ->
        @_muffin = @component 'Database.CouchMuffin',
            dataSourceName: 'Couchbase'
            validate:
                id: {}
                name:
                    notEmpty:
                        required: true
                    maxLength:
                        params: [30]
                        required: true
                description:
                    maxLength:
                        params: [100]
            type: 'recipes'
            keyPrefix: 'recipes_'
            autoId: 'counter'
        @_muffin.bind(@)


    findIngredientsByRecipeId: (recipeId, callback) ->
        @query '''
        SELECT ingredient.*, quantity
        FROM recipe_ingredient
        INNER JOIN ingredients AS ingredient
        ON ingredient.id = recipe_ingredient.ingredient_id
        WHERE recipe_ingredient.recipe_id = ?''', [recipeId], callback

    findAllWithIngredients: (callback) ->
        @findAll({}, (error, recipes) =>
            return callback(error) if error

            @query '''
            SELECT recipe_ingredient.recipe_id AS recipe_id, ingredient.*, quantity
            FROM recipe_ingredient
            INNER JOIN ingredients AS ingredient
            ON ingredient.id = recipe_ingredient.ingredient_id
            ORDER BY recipe_ingredient.recipe_id ''', (error, ingredients) ->

                return callback(error) if error

                for recipe in recipes
                    recipe.ingredients = []
                    for ingredient in ingredients
                        if recipe.id is ingredient.recipe_id
                            delete ingredient.recipe_id
                            recipe.ingredients.push ingredient

                callback(null, recipes)
        )

module.exports = Recipe
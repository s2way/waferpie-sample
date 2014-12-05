class Recipes
    handleError: (error) ->
        @statusCode = 500
        return error: error

    timeout: ->

    before: (callback) ->
        @recipe = @model "#{@core.currentDataSource}.Recipe"
        @ingredient = @model "#{@core.currentDataSource}.Ingredient"
        @recipeIngredient = @model "#{@core.currentDataSource}.RecipeIngredient"
        @responseHeaders['Access-Control-Allow-Origin'] = '*'
        @responseHeaders['Access-Control-Allow-Headers'] = 'Content-Type'
        callback true

    delete: (callback) ->
        id = @segments[0]

        if id is 'all'
            @recipe.removeAll((error) =>
                return callback(@handleError error) if error
                callback({})
            )
        else
            @recipe.removeById(id, (error) =>
                return callback(@handleError error) if error
                callback({})
            )

    addIngredientToRecipe: (recipeId, ingredientId, callback) ->
        @ingredient.findById ingredientId, (error, result) =>
            return callback(@handleError error) if error
            if result is null
                @statusCode = 404
                return callback(error: 'Ingredient not found')

            data =
                recipe_id: recipeId
                ingredient_id: parseInt(ingredientId)
                quantity: @payload.quantity

            @recipeIngredient.save
                data: data
                callback: (error, data) =>
                    return callback(@handleError error) if error
                    @statusCode = 201
                    callback data

    put: (callback) ->

        if @payload is null or typeof @payload isnt 'object'
            return callback(@handleError message: 'Invalid payload')

        id = parseInt(@segments[0])
        ingredientId = @segments[1]

        if isNaN(id)
            @statusCode = 400
            return callback(error: 'Invalid id')

        @recipe.findById id, (error, result) =>
            return callback(@handleError error) if error
            if result is null
                @statusCode = 404
                return callback(error: 'Recipe not found')

            if ingredientId
                @addIngredientToRecipe(id, ingredientId, callback)
                return

            data = @payload
            data['id'] = id

            @recipe.save
                data: data
                callback: (error, result) =>
                    return callback(@handleError error) if error
                    callback result

    post: (callback) ->
        delete @payload['id']
        @recipe.save(
            data: @payload,
            callback: (error, data) =>
                return callback(@handleError error) if error
                @statusCode = 201
                callback data
        )

    get: (callback) ->
        id = @segments[0]
        if id
            @recipe.findById(id, (error, recipe) =>
                return callback(@handleError error) if error
                if recipe is null
                    @statusCode = 404
                    return callback(name: 'NotFound')

                @recipe.findIngredientsByRecipeId(id, (error, ingredients) =>
                    return callback(@handleError error) if error
                    recipe.ingredients = ingredients
                    callback recipe
                )
            )
            return

        @recipe.findAllWithIngredients((error, recipes) =>
            return callback(@handleError error) if error

            callback
                count: recipes.length
                data: recipes
        )

module.exports = Recipes
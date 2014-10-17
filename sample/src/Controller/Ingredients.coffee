class Ingredients
    @handleError: (error) ->
        @statusCode = 500;
        return {
            'message' : error.toString()
            'error' : error
        }
    delete: (callback) ->
        $ = this
        id = @segments[0]
        ingredient = @model('Ingredient')
        ingredient.delete(id, (error, response) ->
            return callback($.handleError error) if error
            callback response
        )
    put: (callback) ->
        $ = this
        ingredient = @model('Ingredient')
        ingredient.save(@payload, (error, response) ->
            return callback($.handleError error) if error
            callback response
        )
    get: (callback) ->
        $ = this
        ingredient = @model('Ingredient')
        key = @segments[0]
        query = @query.query
        if key
            ingredient.findByKey(key, (error, result) ->
                return callback($.handleError error) if error
                $.statusCode = 404 if result is null
                callback result
            )
        ingredient.findAll(query, (error, results) ->
            return callback($.handleError error) if error
            callback results.hits.hits
        )

module.exports = Ingredients
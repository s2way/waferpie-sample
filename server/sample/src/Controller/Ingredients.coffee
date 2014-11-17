class Ingredients
    _handleError: (error) ->
        @statusCode = 500
        return {
            'error' : error
        }

    before: (callback) ->
        @_ingredient = @model(@core.currentDataSource + '.Ingredient')
        callback true

    delete: (callback) ->
        id = @segments[0]

        if id is 'all'
            @_ingredient.removeAll((error, response) =>
                return callback(@_handleError error) if error
                callback response
            )
        else
            @_ingredient.removeById(id, (error) =>
                return callback(@_handleError error) if error
                callback({})
            )

    post: (callback) ->
        delete @payload['id']
        @_ingredient.save(
            data: @payload,
            callback: (error, data) =>
                return callback(@_handleError error) if error
                callback data
        )

    get: (callback) ->
        id = @segments[0]
        if id
            @_ingredient.findById(id, (error, result) =>
                return callback(@_handleError error) if error
                @statusCode = 404 ; callback(name: 'NotFound') if result is null
                callback result
            )
            return

        @_ingredient.findAll(callback: (error, results) =>
            return callback(@_handleError error) if error
            callback
                count: results.length
                data: results
        )

module.exports = Ingredients
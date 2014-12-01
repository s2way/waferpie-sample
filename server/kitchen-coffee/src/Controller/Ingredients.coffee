class Ingredients
    handleError: (error) ->
        @statusCode = 500
        return error: error

    timeout: ->

    before: (callback) ->
        @ingredient = @model(@core.currentDataSource + '.Ingredient')
        callback true

    delete: (callback) ->
        id = @segments[0]

        if id is 'all'
            @ingredient.removeAll((error) =>
                return callback(@handleError error) if error
                callback({})
            )
        else
            @ingredient.removeById(id, (error) =>
                return callback(@handleError error) if error
                callback({})
            )

    put: (callback) ->

        if @payload is null or typeof @payload isnt 'object'
            return callback(@handleError message: 'Invalid payload')

        id = parseInt(@segments[0])
        if isNaN(id)
            @statusCode = 400
            return callback(error: 'Invalid id')

        @ingredient.findById id, (error, result) =>
            return callback(@handleError error) if error
            if result is null
                @statusCode = 404
                return callback({})

            data = @payload
            data['id'] = id

            @ingredient.save
                data: data
                callback: (error, result) =>
                    return callback(@handleError error) if error
                    callback result

    post: (callback) ->
        delete @payload['id']
        @ingredient.save(
            data: @payload,
            callback: (error, data) =>
                return callback(@handleError error) if error
                @statusCode = 201
                callback data
        )

    get: (callback) ->
        id = @segments[0]
        if id
            @ingredient.findById(id, (error, result) =>
                return callback(@handleError error) if error
                if result is null
                    @statusCode = 404
                    return callback(name: 'NotFound')
                callback result
            )
            return

        @ingredient.findAll(
            callback: (error, results) =>
                return callback(@handleError error) if error
                callback
                    count: results.length
                    data: results
        )

module.exports = Ingredients
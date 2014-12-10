class Chefs

    before : (callback) ->
        callback()

    get : (callback) ->

        id = @segments[0] || null

        model = @model 'MySQL.Chef'

        if id is null
            model.findAll 
                callback : (err, data) =>
                    if err
                        @statusCode = 500
                        callback err
                    else
                        callback data
        else 
            model.findById 1, (err, data) =>
                if err
                    @statusCode = 500
                    callback err
                else
                    callback data

    post : (callback) ->

        payload = @payload || null

        model = @model 'MySQL.Chef'

        if payload is null
            callback error : 'No data to be saved'
        else
            model.save 
                data : payload
                callback : (err, result) =>
                    if err
                        @statusCode = 500
                        callback err
                    else
                        @statusCode = 201
                        callback result

    delete : (callback) ->

        id = @segments[0] || null
        model = @model 'MySQL.Chef'

        if id is null
            callback {error : 'No chef to be deleted'}
        else 
            model.removeById id, (err) =>
                if err
                    @statusCode = 500
                    callback err
                else
                    callback message : 'done'

module.exports = Chefs
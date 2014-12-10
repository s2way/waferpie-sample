class Logger

    before: (callback) ->
        log = @model 'MySQL.Log'

        data =
            method: @method
            url: @url
            controller: @controller
            segments: JSON.stringify(@segments)
            query: JSON.stringify(@query)
            prefixes: JSON.stringify(@prefixes)
            requestHeaders: JSON.stringify(@requestHeaders)
            payload: JSON.stringify(@payload)
            params: JSON.stringify(@params)

        log.save data, (error) ->
            if error then callback(error : error) else callback()


module.exports = Logger
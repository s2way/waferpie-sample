class Log
    init: ->
        @_ninja = @component 'Database.MyNinja',
            dataSourceName: 'MySQL'
            table: 'logs'

    save: (data, callback) ->
        @_ninja.save 
            data : data
            callback : (err, data) ->
                if err then callback(err) else callback(null, data)

module.exports = Log
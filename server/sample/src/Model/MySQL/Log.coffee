class Log
    init: ->
        @_ninja = @component 'Database.MyNinja',
            dataSourceName: 'MySQL'
            table: 'logs'

    save: (data, callback) ->
        @_ninja.save data, (error, result) ->
            return callback(error) if error
            return callback(null, result)

module.exports = Log
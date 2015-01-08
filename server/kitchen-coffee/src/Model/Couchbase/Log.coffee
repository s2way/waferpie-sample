class Log
    init: ->
        @_muffin = @component 'Database.CouchMuffin',
            dataSourceName: 'Couchbase'
            type: 'logs'
            keyPrefix: 'logs_'
            autoId: 'counter'

    save: (data, callback) ->
        @_muffin.save data, (error, result) ->
            return callback(error) if error
            return callback(null, result)

module.exports = Log
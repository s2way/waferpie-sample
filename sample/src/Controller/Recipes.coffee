class Recipes
    constructor: ->
    get: (callback) ->
        myself = @component('Bridge', 'myself')
        myself.put('recipes', {}, (error, response) ->
            callback response.body
        )
    put: (callback) ->
        callback { 'ok' : false }

module.exports = Recipes
class Limbo

    before: (callback) ->
        @_limboComponent = @component 'Limbo'
        callback()

    get: (callback) ->
        callback @limbo

    put: (callback) ->
        name = @segments[0]
        if name
            callback @_limboComponent.add name, @payload
        else
            callback error: 'Provide a segment with the var name'

    delete: (callback) ->
        name = @segments[0]
        if name
            callback @_limboComponent.remove name
        else
            callback error: 'Provide a segment with the var name'

module.exports = Limbo
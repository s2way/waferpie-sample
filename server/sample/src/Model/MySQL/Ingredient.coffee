class Ingredient
    constructor: ->
        return
    init: ->
        @_rules = @component 'Rules'
        @_ninja = @component 'Database.MyNinja',
            dataSourceName: 'MySQL'
            validate:
                name: (value, data, callback) =>
                    callback(@_rules.test(value,
                        notEmpty:
                            rule: 'notEmpty',
                            message: 'This field cannot be empty',
                        maxLength:
                            rule: 'maxLength',
                            params: [10]
                    ))
            table: 'ingredients'

    removeAll: (callback) ->
        @_ninja.removeAll(callback)

    removeById: (id, callback) ->
        @_ninja.removeById id, callback

    save: (data, callback) ->
        @_ninja.save
            data: data
            callback: callback

    findById: (id, callback) ->
        @_ninja.findById id, callback

    findAll: (callback) ->
        @_ninja.findAll callback

module.exports = Ingredient
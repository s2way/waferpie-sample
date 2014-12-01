class Ingredient
    constructor: ->
        return
    init: ->
        @_ninja = @component 'Database.MyNinja',
            dataSourceName: 'MySQL'
            validate:
                id: {}
                name:
                    notEmpty:
                        required: true
                    maxLength:
                        params: [30]
                        required: true
            table: 'ingredients'
        @_ninja.bind(@)

module.exports = Ingredient
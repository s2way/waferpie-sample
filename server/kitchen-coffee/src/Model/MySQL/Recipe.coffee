class Recipe
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
                description:
                    maxLength:
                        params: [100]
            table: 'recipes'
        @_ninja.bind(@)

module.exports = Recipe
class Ingredient
    constructor: ->
        return
    init: ->
        @_muffin = @component 'Database.CouchMuffin',
            dataSourceName: 'Couchbase'
            validate:
                id: {}
                name:
                    notEmpty:
                        required: true
                    maxLength:
                        params: [30]
                        required: true
            type: 'ingredients'
            keyPrefix: 'ingredients_'
            autoId: 'counter'
            counterKey: 'counter'
        @_muffin.bind @

module.exports = Ingredient
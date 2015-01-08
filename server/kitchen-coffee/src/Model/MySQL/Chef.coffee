class Chef

    init : ->
        options = 
            table : 'chef'
            dataSourceName : 'MySQL'
            validate :
                name : 
                    notEmpty :
                        rule : 'notEmpty'
                        message : 'Name cannot be empty you stupid motherfucker'
                        required : true
                specialities :
                    isString : 
                        rule : 'isString'
                        message : 'This field is a string, asshole'
                        required : true
                weight :
                    min : 
                        rule : 'min'
                        params : [20]
                        message : 'This chef is too skinny'
                    max : 
                        rule : 'max'
                        params : [150]
                        message : 'Yo mama is so fat'

        @ninja = @component 'Database.MyNinja', options
        @ninja.bind @

module.exports = Chef
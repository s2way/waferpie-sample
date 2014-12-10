chef1 = id: 1, name: 'Josh', weight: '150kg'
chef2 = id: 2, name: 'Jonny', weight: '60kg'

class Chef

    save: (data, callback) ->
        # Salva dados
        chance = Math.floor((Math.random() * 10) + 1) > 5;
        if chance
            callback error : 'Weird error'
        else 
            callback id : 1

    findAll: (callback) ->
        # Busca no banco de dados
        chance = Math.floor((Math.random() * 10) + 1) > 5;
        if chance
            callback error : 'Weird error'
        else 
            callback null, [chef1, chef2]

    removeById: (id, callback) ->
        # Remove por id no banco de dados
        chance = Math.floor((Math.random() * 10) + 1) > 5;
        if chance
            callback error : 'Weird error'
        else 
            callback null

    findById: (id, callback) ->
        # Busca por id no banco de dados
        chance = Math.floor((Math.random() * 10) + 1) > 5;
        if chance
            callback error : 'Weird error'
        else 
            callback null, chef1


module.exports = Chef
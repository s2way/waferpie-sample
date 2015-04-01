class Limbo

	add: (name, value) -> @limbo[name] = value ; @limbo
	remove: (name) -> delete @limbo[name] ; @limbo

module.exports = Limbo
class MyComponent

    init : ->
        console.log 'MyComponent.init()'

    square : (x) -> x * x

    destroy : ->
        console.log 'MyComponent.destroy()'

module.exports = MyComponent
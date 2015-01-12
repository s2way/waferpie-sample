expect = require 'expect.js'
Loader = require('waferpie').Loader

Ingredients = ->

    core =
        dataSources:
            default:
                host: 'localhost'
                port: '8091'
        bridges:
            sample :
                host: 'localhost'
                port: '8001'
                app: 'kitchen-coffee'

    loader = new Loader('./', core)
    bridge = loader.createComponent('Bridge', 'sample')
    bridge.init()

    couchbase = loader.createComponent('Database.Couchbase', '')

    @Given /^there are some ingredients$/, (callback) ->

        callback()

    body = null

    @When /^I dispatch the GET request passing no parameters$/, (callback) ->
        bridge.get('Ingredients', {}, (error, response) ->
            body = response.body
            callback()
        )

    @Then /^I should receive all the ingredients/, (callback) ->
        expect(body.count).to.be.greaterThan(0)
        expect(body.data).to.be.ok()

        callback()

module.exports = Ingredients
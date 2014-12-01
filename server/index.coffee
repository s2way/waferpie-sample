WaferPie = require 'waferpie'
wafer = new WaferPie
wafer.configure('config.yml')
wafer.setUp('kitchen-coffee')
wafer.start('0.0.0.0', 8001)

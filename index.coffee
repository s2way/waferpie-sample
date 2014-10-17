WaferPie = require 'waferpie'
wafer = new WaferPie
wafer.configure('config.yml')
wafer.setUp('sample')
wafer.start('0.0.0.0', 8001)

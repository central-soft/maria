demo = require('./demo_module')

module.exports = (robot) ->
  robot.respond /demo (.*)/i, (msg) ->
    msg.send demo.demoFunc(msg.match[1])
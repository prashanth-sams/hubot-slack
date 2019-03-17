child_process = require('child_process')

module.exports = (robot) ->

  robot.respond /hello/i, (msg) ->
      msg.send "Hello, Mr. Prashanth Sams!"

  robot.respond /calendar( me)?/i, (msg) ->
    child_process.exec 'cal -h', (error, stdout, stderr) ->
      msg.send(stdout)

  robot.hear /say hi in website channel/i, (res) ->
      room = "website"
      robot.messageRoom room, "Saying Hi! in website channel"

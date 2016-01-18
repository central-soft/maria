module.exports = (robot) ->

  robot.hear /こんにちは/i, (msg) ->
    msg.send "こんにちは！"

  robot.hear /疲れた/i, (msg) ->
    msg.send "がんばって！"

  robot.hear /ぬるぽ/i, (msg) ->
    msg.send "ｶﾞｯ!!"

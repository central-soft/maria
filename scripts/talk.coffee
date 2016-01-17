module.exports = (robot) ->

  robot.hear /疲れた/i, (msg) ->
    msg.send "がんばって！"

  robot.hear /ぬるぽ/i, (msg) ->
    msg.send "ｶﾞｯ!!"

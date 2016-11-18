module.exports = (robot) ->
  robot.respond /who are you/i, (msg) ->
    msg.send "I'm hubot!"
 
  robot.hear /HELLO$/i, (msg) ->
    msg.send "hello!"
 
  robot.respond /who am I/i, (msg) ->
    msg.send "You are #{msg.message.user.name}"

  robot.respond /今日も(.*)/i, (msg) ->
    msg.send "今日も #{msg.match[1]} がんばるぞい"

  robot.respond /twitter (.*)/i, (msg) ->
    keyword = encodeURIComponent msg.match[1]
    request = msg.http('https://api.twitter.com/1.1/account/verify_credentials.json')
                          .query(q: keyword)
                          .get()
    request (err, res, body) ->
      msg.send err
      msg.send res
      msg.send body
      
  robot.respond /janken (.*)/i , (msg)->
    te = ["ぐー", "ちょき", "ぱー"]
    index = Math.floor(Math.random()*2)
    
    if msg.match[1] == "gu"
      msg.send "わたしは #{te[index]} を出しました。あいこです"
    else
      msg.send "hoge"
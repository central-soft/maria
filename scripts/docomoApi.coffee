# Description
#   マリアちゃんと雑談をする
#
# Configuration:
#   DOCOMO_API_KEY
#
# Notes:
#   ドコモの雑談対話APIを利用して、マリアちゃんとの会話を行う。
#   会話の継続も可能（３分経つと破棄される）
module.exports = (robot) ->
  ERR_MSG = '雑談対話APIの呼出に失敗しました。'
  API_KEY = process.env.DOCOMO_API_KEY

  status = { place: '東京' }

  robot.respond /(\S+)/i, (msg) ->

    # APIキーおよびメッセージがない場合は無視
    message = msg.match[1]
    return unless API_KEY && message

    status.nickname = msg.envelope.user.name
    status.utt = msg.match[1]

    # ３分でメッセージを破棄
    now = new Date().getTime()
    if now - status.time > 3 * 60 * 1000
      status.context = ''
      status.mode = ''

    # API接続
    msg
      .http('https://api.apigw.smt.docomo.ne.jp/dialogue/v1/dialogue')
      .query(APIKEY: API_KEY)
      .header('Content-Type', 'application/json')
      .post(JSON.stringify(status)) (err, res, body) ->
        if err? or res.statusCode isnt 200
          return msg.reply("#{ERR_MSG}\n```\n#{err}\n```")
        msg.reply(JSON.parse(body).utt)
        #robot.logger.debug status
        #robot.logger.debug body
        status.time = now
        status.context = JSON.parse(body).context
        status.mode = JSON.parse(body).mode

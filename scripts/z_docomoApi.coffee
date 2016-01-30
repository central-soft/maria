# Description
#   ドコモの雑談対話APIを利用して、マリアちゃんと雑談をする
#
# Configuration:
#   DOCOMO_API_KEY
#
# Notes:
#　　本機能は、どのコマンドにも該当しなかった場合のみ起動します。
#　　コマンド一覧を取得すつため、
#　　ファイル名にｚをつけて最後に読み込まれるようになっています。
#   会話の継続も可能です。（３分経つと破棄される）
module.exports = (robot) ->

  # コマンド一覧を取得する
  cmds = []
  for help in robot.helpCommands()
    cmd = help.split(' ')[1]
    cmds.push cmd if cmds.indexOf(cmd) is -1

  # 定数
  ERR_MSG = '雑談対話APIの呼出に失敗しました。'
  API_KEY = process.env.DOCOMO_API_KEY
  status = { place: '東京' }

  robot.respond /(.+)$/i, (msg) ->

    # 該当コマンドが存在する場合、処理中止
    cmd = msg.match[1].split(' ')[0]
    return unless cmds.indexOf(cmd) is -1

    # APIキーおよびメッセージがない場合は、処理中止
    message = msg.match[1]
    return unless API_KEY && message

    # ユーザ名とメッセージを取得
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

        status.time = now
        status.context = JSON.parse(body).context
        status.mode = JSON.parse(body).mode

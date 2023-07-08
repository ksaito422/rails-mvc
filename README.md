# Rails MVC

mvcアーキテクチャに則って、ブログ投稿アプリをrailsキャッチアップ用に作ってみる。

## エラー解消

node18系で`bin/rails webpacker/compile`や`bin/rails s`を実行すると、
`Error: error:0308010C:digital envelope routines::unsupported`のエラーが表示される場合

以下を実行する
`export NODE_OPTIONS=--openssl-legacy-provider`

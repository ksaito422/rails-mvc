# Rails MVC

mvcアーキテクチャに則って、ブログ投稿アプリをrailsキャッチアップ用に作ってみる。

## 機能とエンドポイント

- ログインページ `GET /login`
- ログイン `POST /login`
- ログアウト `DELETE /logout`
- ユーザー登録ページ `GET /users`
- ユーザー登録 `POST /users`
- 退会ページ `GET /users/:id/delete`
- 退会 `DELETE /users/:id`
- 記事一覧 `GET /articles`
- 記事投稿ページ `GET /articles/new`
- 記事投稿 `POST /articles`
- 記事編集ページ `GET /articles/:id`
- 記事編集 `PUT /articles/:id`
- 記事詳細 `GET /articles/:id`
- 記事削除 `DELETE /articles/:id`
- コメント投稿 `POST /articles/:id/comments`
- コメント編集ページ `GET /articles/:id/comments/:id`
- コメント編集 `POST /articles/:id/comments/:id`
- コメント削除 `DELETE /articles/:id/comments/:id`

# サーバ/インフラエンジニア養成読本 Kibanaテストデータ 

## テストデータの内容について

テストデータは1ファイルです。

テストデータは架空のWebサービスのイベントログを想定しています。
イベントログには次の情報が含まれています。

| フィールド名 | 説明 |
|:-------------|:-----|
| `@timestamp` | タイムスタンプ |
| `@service` | 固定(sample_service) |
| `user_name` | ユーザー名 |
| `user_sex` | 性別 |
| `user_age` | 年齢 |
| `user_country` | 国情報 |
| `message` | ランダムなテキスト文字列 |
| `location` | GeoLocation形式の位置情報 |

`events.json`は書籍で使用した2014年4月27日に生成したデータが記録されています。
Kibanaで閲覧する際は、この期間にあわせて指定してください。
もしくは下記方法で現在時刻付近のテストデータを生成することが出来ます。

## テストデータの生成方法について

テストデータを生成する場合は下記スクリプトを実行してください。
Elasticsearchのbulk insert形式のレコードが出力されます。

```
cd ./script
bundle install --path vendor/bundle
ruby ./src/generate_events.rb > events.json
```

実行にはMaxMind社のFree World Cities Databaseが必要です。
下記Webサイトからダウンロードすることが出来ます。

- [MaxMind - Free World Cities Database](https://www.maxmind.com/en/worldcities)

ダウンロードしたファイルは解凍し、`./script`ディレクトリに配置してください。

## License

- このサンプルデータは下記ライセンスで配布されます。
  - TODO ライセンス表記

- MixMind社のFree World Cities DatabaseはMaxMind社が定めるライセンスに従い配布されています。詳細は下記ページをご覧ください。
  - https://www.maxmind.com/en/worldcities



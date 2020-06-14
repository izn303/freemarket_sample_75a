# README
# アプリケーション概要
フリーマーケットのアプリケーションの開発です。メルカりを参考にしています。４人でアジャイル開発を行います。

# 機能一覧
- ユーザー新規登録、ログイン、ログイン（メールアドレスのみ）
- 商品出品
- 購入機能

# 使用技術
## 言語
  - Ruby 2.5.1
## フレームワーク
  - Ruby on Rails 5.2.4.3
## データベース
  - MySQL 5.6.47
## インフラ
  - AWS EC2
  - AWS S3

# ER図
  https://gyazo.com/10c37b3245ddfb45cd625c850661abb8

#  DB設計
## userテーブル
|column|Type|Option|
|------|----|------|
|nickname|string|null: false|
|email|string|null: false,unique: true, index:true|
|password|string|null: false, length:{minimu:6}|
|password_conform|string|null:false|
### Association
- has_many : items,dependent:delete_all
- has_one : profile, dependent: :delete
- has_one : credit_card, dependent: :delete

## profileテーブル
|column|Type|Option|
|------|----|------|
|phone_number|string||
|first_name|string|null: false|
|family_name|string|null: false,|
|first_name_kana|string|null: false|
|family_name_kana|string|null: false|
|birthday|data|null: false|
|introduction|text||
|post_number|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|house_number|string|null: false|
|building_name|string||
|user|references|null:false,foreign_key:true|

### Association
- belongs_to : user

## credit_cardテーブル
|column|Type|Option|
|------|----|------|
|user|references|null: false, foreign_key: true|
|card_number|integer|null: false ,unique: true|
|expiration_year|integer|null: false|
|expiration_month|integer|null: false|
|security_code|integer|null: false|

### Association
- belongs_to : user

## itemテーブル
|column|Type|Option|
|------|----|------|
|name|string|null: false,|
|introduction|text|null: false,|
|price|integer|null: false|
|shipment_date|string|null: false|
|shipment_pref|string|null: false|
|category|reference|null: false, foreign_key: true|
|brand|string||
|item_status|string|null: false|
|shipment_fee|string|null: false|
|seller|reference|null: false, foreign_key: true|
|buyer|reference|foreign_key: true|
### Association
- belongs_to : user
- belongs_to : category
- had_many: item_imgs, dependent::destroy

## imageテーブルテーブル
|column|Type|Option|
|------|----|------|
|url|string|null:false|
|item|reference|null:false,foregin_key:true|
### Association
- belongs_to : item

## categoryテーブルテーブル
|column|Type|Option|
|------|----|------|
|name|string|null:false|
|ancestry|string|null:false|
### Association
- has_many: items


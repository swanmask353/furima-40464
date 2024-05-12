# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| family_name        | string | null: false |
| first_name         | string | null: false |
| nick_name          | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |


### Association

- has_many :user_items
- has_many :items, through: :user_items


## user_items テーブル

| Column | Type       | Options     |
| ------ | -----------| ----------- |
| user   | references | null: false,foreign_key: true  |
| room   | references | null: false,foreign_key: true  |


### Association

- belongs to : user
- belongs to :item

## itemsテーブル

| Column        | Type       | Options             |
| ------        | ---------- | ------------------- |
| content       | text       | null: false |
| item_name     | text       | null: false |
| discription   | text       | null: false |
|category       | references | null: false, foreign_key: true|
|condition      | references | null: false, foreign_key: true|
|postage        | references | null: false, foreign_key: true|
|region         | references | null: false, foreign_key: true|
|shipping_date  | references | null: false, foreign_key: true|
| price         | text       | null: false |

### Association

- has_many :users, through: :user_items
- has_many :comments


## comments テーブル

| Column    | Type       | Options             |
| ------    | ---------- | ------------------- |
| content   | text       | null: false |
| item      | references | null: false, foreign_key: true |
| user      | references | null: false, foreign_key: true |


### Association

- belongs_to item
- belongs_to :user
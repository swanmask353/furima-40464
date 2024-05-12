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
| item   | references | null: false,foreign_key: true  |


### Association

- belongs to : user
- belongs to :item

## itemsテーブル

| Column        | Type       | Options             |
| ------        | ---------- | ------------------- |
| content       | text       | null: false |
| item_name     | text       | null: false |
| discription   | text       | null: false |
|category       | references | null: false |
|condition      | references | null: false |
|postage        | references | null: false |
|region         | references | null: false |
|shipping_date  | references | null: false |
| price         | integer    | null: false |

### Association

- has_many :users, through: :user_items
- has_many :comments


## comments テーブル

| Column    | Type       | Options             |
| ------    | ---------- | ------------------- |
| comment   | text       | null: false |
| user_id   | references | null: false, foreign_key: true |
| item_id   | references | null: false, foreign_key: true |


### Association

- belongs_to item
- belongs_to :user
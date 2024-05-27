# テーブル設計

## Users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| nickname           | string | null: false |
| birthday           | date   | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |


### Association

- has_many :products
- has_many :purchase_records


## Itemsテーブル

| Column             | Type       | Options             |
| ------             | ---------- | ------------------- |
| user               | references | null: false, foreign_key: true |
| title              | string     | null: false |
| description        | text       | null: false |
| price              | integer    | null: false |
|category_id         | integer    | null: false |
|condition_id        | integer    | null: false |
|shipping_cost_id    | integer    | null: false |
|prefecture_id       | integer    | null: false |
|shipping_duration_id| integer    | null: false |


### Association

- belongs_to :user
- has_one :purchase_record


## Purchase Records テーブル

| Column              | Type       | Options             |
| ------              | ---------- | ------------------- |
| user                | references | null: false, foreign_key: true |
| item             | references | null: false, foreign_key: true |


### Association

- belongs_to :user
- belongs_to :product
- has_one :shipping_address

## Shipping Addresses テーブル

| Column          | Type       | Options             |
| ------          | ---------- | ------------------- |
| purchase_record | references | null: false, foreign_key: true |
| postal_code     | string     | null: false |
| prefecture_id   | integer    | null: false |
| city            | string     | null: false |
| address_line1   | string     | null: false |
| address_line2   | string     |             |
| phone_number    | string     | null: false |


### Association

- belongs_to :purchase_record
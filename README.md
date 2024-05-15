# テーブル設計

## Users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| last_name          | string | null: false |
| first_name         | string | null: false |
| nick_name          | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |


### Association

- has_many :products
- has_many :purchase_records
- has_many :shipping_addresses


## Productsテーブル

| Column             | Type       | Options             |
| ------             | ---------- | ------------------- |
| user_id            | references | null: false, foreign_key: true |
| title              | string     | null: false |
| description        | text       | null: false |
| price              | integer    | null: false |
|category_id         | integer    | null: false |
|condition_id        | integer    | null: false |
|shipping_cost_id    | integer    | null: false |
|shipping_region_id  | integer    | null: false |
|shipping_duration_id| integer  | null: false |
|image_url           | string     | null: false |


### Association

- belongs_to :users
- has_one purchase_records


## Purchase Records テーブル

| Column              | Type       | Options             |
| ------              | ---------- | ------------------- |
| user_id             | references | null: false, foreign_key: true |
| product_id          | references | null: false, foreign_key: true |
| shipping_address_id | references | null: false, foreign_key: true |

### Association

- belongs_to :products
- has_many :users
- has_many :shipping_Addresses

## Shipping Addresses テーブル

| Column        | Type       | Options             |
| ------        | ---------- | ------------------- |
| user_id       | references | null: false, foreign_key: true |
| postal_code   | string     | null: false |
| prefecture    | string     | null: false |
| city          | string     | null: false |
| address_line1 | string     | null: false |
| address_line2 | string     | null: false |
| phone_number  | string     | null: false |


### Association

- belongs_to :users
- has_many :purchase_records
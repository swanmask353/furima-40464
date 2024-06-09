class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_cost
  belongs_to_active_hash :shipping_duration

  belongs_to :user
  has_one_attached :image
  #has_one :purchase_record

  #def sold_out?
    #self.purchase_record.present?
  #end

  validates :title, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :description, presence: true
  validates :image, presence: true
  validates :category_id, presence: true, numericality: { other_than: 0 }
  validates :condition_id, presence: true, numericality: { other_than: 0 }
  validates :prefecture_id, presence: true, numericality: { other_than: 0 }
  validates :shipping_cost_id, presence: true, numericality: { other_than: 0 }
  validates :shipping_duration_id, presence: true, numericality: { other_than: 0 }
end

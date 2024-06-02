require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品出品' do
    before do
      @item = FactoryBot.build(:item)
    end

    context '正常な場合' do
      it 'すべての属性が正しく設定されていれば保存できる' do
        expect(@item).to be_valid
      end
    end

    context '異常な場合' do
      it 'priceが空では保存できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors[:price]).to include("can't be blank")
      end

      it 'priceが300未満では保存できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors[:price]).to include("must be greater than or equal to 300")
      end

      it 'priceが10,000,000以上では保存できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors[:price]).to include("must be less than or equal to 9999999")
      end

      it 'priceが整数でなければ保存できない' do
        @item.price = '300.5'
        @item.valid?
        expect(@item.errors[:price]).to include("must be an integer")
      end

      it 'descriptionが空では保存できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors[:description]).to include("can't be blank")
      end

      it 'imageが空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors[:image]).to include("can't be blank")
      end

      it 'categoryが選択されていなければ保存できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors[:category_id]).to include("must be other than 0")
      end

      it 'conditionが選択されていなければ保存できない' do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors[:condition_id]).to include("must be other than 0")
      end

      it 'prefectureが選択されていなければ保存できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors[:prefecture_id]).to include("must be other than 0")
      end

      it 'shipping_costが選択されていなければ保存できない' do
        @item.shipping_cost_id = 0
        @item.valid?
        expect(@item.errors[:shipping_cost_id]).to include("must be other than 0")
      end

      it 'shipping_durationが選択されていなければ保存できない' do
        @item.shipping_duration_id = 0
        @item.valid?
        expect(@item.errors[:shipping_duration_id]).to include("must be other than 0")
      end

      it 'userが紐付いていなければ保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors[:user]).to include("must exist")
      end
    end
  end
end

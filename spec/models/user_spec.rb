require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    context '正常な場合' do
      it '全ての項目が正しく入力されている場合、ユーザーを登録できること' do
        user = FactoryBot.build(:user) # FactoryBotを使用してユーザーオブジェクトを作成
        expect(user).to be_valid # ユーザーオブジェクトが有効かどうかを検証
      end
    end

    context '異常な場合' do
      it 'ニックネームが空欄の場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, nickname: '') # ニックネームが空のユーザーオブジェクトを作成
        user.valid? # バリデーションを実行
        expect(user.errors[:nickname]).to include("can't be blank") # エラーメッセージが含まれていることを確認
      end

      it 'メールアドレスが空欄の場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, email: '') # メールアドレスが空のユーザーオブジェクトを作成
        user.valid? # バリデーションを実行
        expect(user.errors[:email]).to include("can't be blank") # エラーメッセージが含まれていることを確認
      end

      it 'メールアドレスが重複している場合、ユーザーを登録できないこと' do
        existing_user = FactoryBot.create(:user, email: 'test@example.com') # 既存のユーザーを作成
        user = FactoryBot.build(:user, email: 'test@example.com') # 重複するメールアドレスを持つユーザーオブジェクトを作成
        user.valid? # バリデーションを実行
        expect(user.errors[:email]).to include('has already been taken') # エラーメッセージが含まれていることを確認
      end

      it 'パスワードが空欄の場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, password: '') # パスワードが空のユーザーオブジェクトを作成
        user.valid? # バリデーションを実行
        expect(user.errors[:password]).to include("can't be blank") # エラーメッセージが含まれていることを確認
      end

      it 'パスワードが6文字未満の場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, password: 'pass') # パスワードが短いユーザーオブジェクトを作成
        user.valid? # バリデーションを実行
        expect(user.errors[:password]).to include("is too short (minimum is 6 characters)") # エラーメッセージが含まれていることを確認
      end

      it 'パスワードが半角英数字混合でない場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, password: 'password') # パスワードが半角英数字混合でないユーザーオブジェクトを作成
        user.valid? # バリデーションを実行
        expect(user.errors[:password]).to include("must include both letters and numbers") # エラーメッセージが含まれていることを確認
      end

      it '姓が空欄の場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, last_name: '') # 姓が空のユーザーオブジェクトを作成
        user.valid? # バリデーションを実行
        expect(user.errors[:last_name]).to include("can't be blank") # エラーメッセージが含まれていることを確認
      end

      it '姓が全角文字でない場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, last_name: 'Yamada') # 姓が半角文字のユーザーオブジェクトを作成
        user.valid? # バリデーションを実行
        expect(user.errors[:last_name]).to include("must be in full-width characters (kanji, hiragana, or katakana)") # エラーメッセージが含まれていることを確認
      end

      it '誕生日が空欄の場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, birthday: nil) # 誕生日が空のユーザーオブジェクトを作成
        user.valid? # バリデーションを実行
        expect(user.errors[:birthday]).to include("can't be blank") # エラーメッセージが含まれていることを確認
      end
    end
  end
end

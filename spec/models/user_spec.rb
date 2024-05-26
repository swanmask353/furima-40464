require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザー新規登録" do
    before do
      @valid_user_attributes = FactoryBot.attributes_for(:user)
    end

    context "正常な場合" do
      it '全ての項目が正しく入力されている場合、ユーザーを登録できること' do
        user = FactoryBot.build(:user, @valid_user_attributes)
        expect(user).to be_valid
      end
    end

    context '異常な場合' do
      it 'ニックネームが空欄の場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, @valid_user_attributes.merge(nickname: ''))
        user.valid?
        expect(user.errors[:nickname]).to include("can't be blank")
      end

      it 'メールアドレスが空欄の場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, @valid_user_attributes.merge(email: ''))
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end

      it 'メールアドレスが重複している場合、ユーザーを登録できないこと' do
        existing_user = FactoryBot.create(:user, email: 'test@example.com')
        user = FactoryBot.build(:user, @valid_user_attributes.merge(email: 'test@example.com'))
        user.valid?
        expect(user.errors[:email]).to include('has already been taken')
      end

      it 'パスワードが空欄の場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, @valid_user_attributes.merge(password: ''))
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end

      it 'パスワードが6文字未満の場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, @valid_user_attributes.merge(password: 'pass'))
        user.valid?
        expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
      end

      it 'パスワードが半角英数字混合でない場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, @valid_user_attributes.merge(password: 'password'))
        user.valid?
        expect(user.errors[:password]).to include("must include both letters and numbers")
      end

      it '姓が空欄の場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, @valid_user_attributes.merge(last_name: ''))
        user.valid?
        expect(user.errors[:last_name]).to include("can't be blank")
      end

      it '姓が全角文字でない場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, @valid_user_attributes.merge(last_name: 'Yamada'))
        user.valid?
        expect(user.errors[:last_name]).to include("must be in full-width characters (kanji, hiragana, or katakana)")
      end

      it '誕生日が空欄の場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, @valid_user_attributes.merge(birthday: nil))
        user.valid?
        expect(user.errors[:birthday]).to include("can't be blank")
      end

      it 'メールアドレスに@が含まれていない場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, email: 'invalid_email.example.com') # @が含まれていないメールアドレスのユーザーオブジェクトを作成
        user.valid? # バリデーションを実行
        expect(user.errors[:email]).to include("is invalid") # エラーメッセージが含まれていることを確認
      end

      it '数字のみのパスワードでは登録できないこと' do
        user = FactoryBot.build(:user, password: '123456') # 数字のみのパスワードを持つユーザーオブジェクトを作成
        user.valid? # バリデーションを実行
        expect(user.errors[:password]).to include("must include both letters and numbers") # エラーメッセージが含まれていることを確認
      end
      
      it '全角文字のパスワードでは登録できないこと' do
        user = FactoryBot.build(:user, password: 'パスワード') # 全角文字のパスワードを持つユーザーオブジェクトを作成
        user.valid? # バリデーションを実行
        expect(user.errors[:password]).to include("must include both letters and numbers") # エラーメッセージが含まれていることを確認
      end

      it '姓が空欄の場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, last_name: '') # 姓が空のユーザーオブジェクトを作成
        user.valid? # バリデーションを実行
        expect(user.errors[:last_name]).to include("can't be blank") # エラーメッセージが含まれていることを確認
      end
    
      it '姓に半角文字が含まれている場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, last_name: 'Yamada1') # 姓に半角文字が含まれているユーザーオブジェクトを作成
        user.valid? # バリデーションを実行
        expect(user.errors[:last_name]).to include("must be in full-width characters (kanji, hiragana, or katakana)") # エラーメッセージが含まれていることを確認
      end
    
      it '名が空欄の場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, first_name: '') # 名が空のユーザーオブジェクトを作成
        user.valid? # バリデーションを実行
        expect(user.errors[:first_name]).to include("can't be blank") # エラーメッセージが含まれていることを確認
      end
    
      it '名に半角文字が含まれている場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, first_name: 'Taro1') # 名に半角文字が含まれているユーザーオブジェクトを作成
        user.valid? # バリデーションを実行
        expect(user.errors[:first_name]).to include("must be in full-width characters (kanji, hiragana, or katakana)") # エラーメッセージが含まれていることを確認
      end

      it '姓のフリガナが空欄の場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, last_name_kana: '') # 姓のフリガナが空のユーザーオブジェクトを作成
        user.valid? # バリデーションを実行
        expect(user.errors[:last_name_kana]).to include("can't be blank") # エラーメッセージが含まれていることを確認
      end
    
      it '姓のフリガナにカタカナ以外の文字が含まれている場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, last_name_kana: 'やまだ') # 姓のフリガナにカタカナ以外の文字が含まれているユーザーオブジェクトを作成
        user.valid? # バリデーションを実行
        expect(user.errors[:last_name_kana]).to include("must be in full-width katakana") # エラーメッセージが含まれていることを確認
      end
    
      it '名のフリガナが空欄の場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, first_name_kana: '') # 名のフリガナが空のユーザーオブジェクトを作成
        user.valid? # バリデーションを実行
        expect(user.errors[:first_name_kana]).to include("can't be blank") # エラーメッセージが含まれていることを確認
      end
    
      it '名のフリガナにカタカナ以外の文字が含まれている場合、ユーザーを登録できないこと' do
        user = FactoryBot.build(:user, first_name_kana: 'たろう') # 名のフリガナにカタカナ以外の文字が含まれているユーザーオブジェクトを作成
        user.valid? # バリデーションを実行
        expect(user.errors[:first_name_kana]).to include("must be in full-width katakana") # エラーメッセージが含まれていることを確認
      end
    end
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザー新規登録" do
    before do
      @user = FactoryBot.build(:user)
    end

    context "正常な場合" do
      it '全ての項目が正しく入力されている場合、ユーザーを登録できること' do
        expect(@user).to be_valid
      end
    end

    context '異常な場合' do
      it 'ニックネームが空欄の場合、ユーザーを登録できないこと' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors[:nickname]).to include("can't be blank")
      end

      it 'メールアドレスが空欄の場合、ユーザーを登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors[:email]).to include("can't be blank")
      end

      it 'メールアドレスが重複している場合、ユーザーを登録できないこと' do
        existing_user = FactoryBot.create(:user, email: 'test@example.com')
        @user.email = 'test@example.com'
        @user.valid?
        expect(@user.errors[:email]).to include('has already been taken')
      end

      it 'パスワードが空欄の場合、ユーザーを登録できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors[:password]).to include("can't be blank")
      end

      it 'パスワードが6文字未満の場合、ユーザーを登録できないこと' do
        @user.password = 'pass'
        @user.valid?
        expect(@user.errors[:password]).to include("is too short (minimum is 6 characters)")
      end

      it 'パスワードが半角英数字混合でない場合、ユーザーを登録できないこと' do
        @user.password = 'password'
        @user.valid?
        expect(@user.errors[:password]).to include("must include both letters and numbers")
      end

      it '姓が空欄の場合、ユーザーを登録できないこと' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors[:last_name]).to include("can't be blank")
      end

      it '姓が全角文字でない場合、ユーザーを登録できないこと' do
        @user.last_name = 'Yamada'
        @user.valid?
        expect(@user.errors[:last_name]).to include("must be in full-width characters (kanji, hiragana, or katakana)")
      end

      it '誕生日が空欄の場合、ユーザーを登録できないこと' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors[:birthday]).to include("can't be blank")
      end

      it 'メールアドレスに@が含まれていない場合、ユーザーを登録できないこと' do
        @user.email = 'invalid_email.example.com'
        @user.valid?
        expect(@user.errors[:email]).to include("is invalid")
      end

      it '数字のみのパスワードでは登録できないこと' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors[:password]).to include("must include both letters and numbers")
      end

      it '全角文字のパスワードでは登録できないこと' do
        @user.password = 'パスワード'
        @user.valid?
        expect(@user.errors[:password]).to include("must include both letters and numbers")
      end

      it '姓に半角文字が含まれている場合、ユーザーを登録できないこと' do
        @user.last_name = 'Yamada1'
        @user.valid?
        expect(@user.errors[:last_name]).to include("must be in full-width characters (kanji, hiragana, or katakana)")
      end

      it '名が空欄の場合、ユーザーを登録できないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors[:first_name]).to include("can't be blank")
      end

      it '名に半角文字が含まれている場合、ユーザーを登録できないこと' do
        @user.first_name = 'Taro1'
        @user.valid?
        expect(@user.errors[:first_name]).to include("must be in full-width characters (kanji, hiragana, or katakana)")
      end

      it '姓のフリガナが空欄の場合、ユーザーを登録できないこと' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors[:last_name_kana]).to include("can't be blank")
      end

      it '姓のフリガナにカタカナ以外の文字が含まれている場合、ユーザーを登録できないこと' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors[:last_name_kana]).to include("must be in full-width katakana")
      end

      it '名のフリガナが空欄の場合、ユーザーを登録できないこと' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors[:first_name_kana]).to include("can't be blank")
      end

      it '名のフリガナにカタカナ以外の文字が含まれている場合、ユーザーを登録できないこと' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors[:first_name_kana]).to include("must be in full-width katakana")
      end
    end
  end
end
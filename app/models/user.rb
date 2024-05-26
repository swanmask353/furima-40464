class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :nickname, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must include @" }
  validates :password, presence: true, length: { minimum: 6 }, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: "must include both letters and numbers" }
  validates :last_name, presence: true, format: { with: /\A[一-龥ぁ-んァ-ヶー]+\z/, message: "must be in full-width characters (kanji, hiragana, or katakana)" }
  validates :first_name, presence: true, format: { with: /\A[一-龥ぁ-んァ-ヶー]+\z/, message: "must be in full-width characters (kanji, hiragana, or katakana)" }
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: "must be in full-width katakana" }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: "must be in full-width katakana" }
  validates :birthday, presence: true

  # Custom validation for password confirmation
  validate :password_confirmation_matches

  private

  def password_confirmation_matches
    if password != password_confirmation
      errors.add(:password_confirmation, "doesn't match Password")
    end
  end
end

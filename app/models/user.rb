class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :nickname, presence: true
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: "must include both letters and numbers" }
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "must be in full-width characters (kanji, hiragana, or katakana)" }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "must be in full-width characters (kanji, hiragana, or katakana)" }
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

class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_many :training_records, dependent: :destroy
  has_many :training_sets, through: :training_records
  has_many :exercises, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.name = "ゲストユーザー"
      user.password = SecureRandom.urlsafe_base64
    end
  end
end

class TrainingRecord < ApplicationRecord
  belongs_to :user
  has_many :training_sets, dependent: :destroy
  has_many :exercises, through: :training_sets

  validates :trained_on, presence: true, uniqueness: { scope: :user_id }
  validates :memo, length: { maximum: 1000 }

  accepts_nested_attributes_for :training_sets, allow_destroy: true, reject_if: :all_blank
end

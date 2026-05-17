class TrainingSet < ApplicationRecord
  belongs_to :training_record
  belongs_to :exercise

  validates :set_number, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :weight, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 999.99 }
  validates :reps, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :memo, length: { maximum: 500 }
end

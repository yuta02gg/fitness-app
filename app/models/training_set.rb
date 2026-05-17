class TrainingSet < ApplicationRecord
  belongs_to :training_record
  belongs_to :exercise
end

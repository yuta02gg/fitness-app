class Exercise < ApplicationRecord
  belongs_to :user
  has_many :training_sets, dependent: :restrict_with_error

  validates :name,
            presence: true,
            length: { maximum: 50 },
            uniqueness: {
              scope: :user_id,
              conditions: -> { where(active: true) }
            }
  validates :body_part, presence: true, length: { maximum: 30 }
  validates :memo, length: { maximum: 500 }
  validates :active, inclusion: { in: [true, false] }

  scope :active, -> { where(active: true) }

  scope :search_by_name, ->(keyword) {
    if keyword.present?
      where("name ILIKE ?", "%#{sanitize_sql_like(keyword)}%")
    else
      all
    end
  }

  def soft_delete
    update(active: false)
  end
end

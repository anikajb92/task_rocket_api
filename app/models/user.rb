class User < ApplicationRecord
  has_secure_password
  has_many :tasks

  validates :username, presence: true, uniqueness: true

  def completed
    total = self.tasks.count
    all_completed = self.tasks.where(completed: true).count
    completed_percentage = ((all_completed.to_f / total.to_f) * 100).to_i
    pending = total - all_completed

    p "You have completed #{completed_percentage}% of your #{total} tasks, which leaves #{pending} tasks remaining."
  end 
end

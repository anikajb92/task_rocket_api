class User < ApplicationRecord
  has_secure_password
  has_many :tasks

  validates :username, presence: true, uniqueness: true

  def sorted_tasks
    pending = self.tasks.where(completed: false)
    sorted = pending.sort_by { |task| [task.priority]}

    sorted
  end
  
  def completed_tasks
    completed = self.tasks.where(completed: true)
    p completed
  end

  def perc_tasks_completed
    total = self.tasks.count
    all_completed = self.tasks.where(completed: true).count
    completed_percentage = ((all_completed.to_f / total.to_f) * 100).to_i
    pending = total - all_completed

    # p "You have completed #{completed_percentage}% of your #{total} tasks, which leaves #{pending} remaining tasks to be completed! You can do it!"
    ["all completed", all_completed, "completed perentage", completed_percentage, "total", total, "pending", pending]
  end 

  def num_tasks_per_category
    work = self.tasks.where(category: "Work").count
    personal = self.tasks.where(category: "Personal").count
    household = self.tasks.where(category: "Household").count
    social = self.tasks.where(category: "Social").count

    ["work", work, "personal", personal, "household", household, "social", social]
  end 

  def avg_completion_time
    all_completed = self.tasks.where(completed: true)
    total = self.tasks.where(completed: true).count

    completion_time = all_completed.map do |task|
      start_date = task.created_at
      # start_time = task.created_at.strftime("%k:%M")
      finish_date = task.updated_at
      # finish_time = task.updated_at.strftime("%k:%M")
      time_diff = (finish_date - start_date)

      time_diff_formatted = (time_diff / 1.day).round
      
      time_diff_formatted
      # puts "This task was created on #{start_date} at #{start_time} and finished on #{finish_date} at #{finish_time}"
    end 

    # avg = (time_diff_formatted.sum / total)

  #  p completion_time.to_f / total.to_f
  end 

  def user_active
    created = self.created_at
    today= Time.now
    time_diff = ((today - created) / 1.hour).round

    time_diff
  end 

  def most_productive_day
    all_completed = self.tasks.where(completed: true)

    completed_weekday = all_completed.map do |task|
      finish_date = task.updated_at.strftime("%A")
    end

    completed_weekday.group_by(&:itself).transform_values(&:count)
    # tally = ^
    # tally.max
  end

end

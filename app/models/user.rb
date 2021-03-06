class User < ApplicationRecord
  has_secure_password
  has_many :tasks

  validates :username, presence: true, uniqueness: true

  def sorted_tasks
    pending = self.tasks.where(completed: false)
    sorted = pending.sort_by { |task| [task.priority]}

    sorted.reverse
  end
  
  def completed_tasks
    init_completed = self.tasks.where(completed: true)
    sorted_completed = init_completed.sort_by { |task| [task.priority]}
    
    sorted_completed.reverse
  end

  def perc_tasks_completed
    total = self.tasks.count
    all_completed = self.tasks.where(completed: true).count
    completed_percentage = ((all_completed.to_f / total.to_f) * 100).to_i
    pending = total - all_completed

    # p "You have completed #{completed_percentage}% of your #{total} tasks, which leaves #{pending} remaining tasks to be completed! You can do it!"
    ["all_completed", all_completed, "completed_perentage", completed_percentage, "total", total, "pending", pending]
  end 

  def num_tasks_per_category
    work = self.tasks.where(category: "Work").count
    personal = self.tasks.where(category: "Personal").count
    household = self.tasks.where(category: "Household").count
    social = self.tasks.where(category: "Social").count

    [["Work", work],["Personal", personal], ["Household", household], ["Social", social]]
  end 

  def most_tasks_per_category
    num_tasks_per_category.sort_by { |k,v| v}.reverse.first
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

      time_diff_formatted = (time_diff / 1.hour).round
      
      time_diff_formatted
      # puts "This task was created on #{start_date} at #{start_time} and finished on #{finish_date} at #{finish_time}"
    end.sum # sum of the entire array 

    avg = (completion_time.to_f / total.to_f) # avg for all tasks

    avg.round(2) # rounds to the nearest .01
  end 

  def user_active
    created = self.created_at
    today= Time.now
    time_diff = ((today - created) / 1.day).round

    time_diff
  end 

  def most_productive_day
    all_completed = self.tasks.where(completed: true)

    completed_weekday = all_completed.map do |task|
      finish_date = task.updated_at.strftime("%A")
    end.group_by(&:itself).transform_values(&:count) # returns hash with "Day"=>tally pairs for each day of the week

    arr = completed_weekday.sort_by { |k , v| v }.reverse #returns array with [Day, value] pairs sorted by highest value first
    
    arr.first #returns first hash in the first pair in the array
  end

  def num_tasks_per_priority
    high = self.tasks.where(priority: '3').count
    medium = self.tasks.where(priority: '2').count
    low = self.tasks.where(priority: '1').count
    
    [["High", high], ["Medium", medium], ["Low", low]]
  end 
end

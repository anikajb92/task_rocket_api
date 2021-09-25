class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :description
      t.string :category
      t.integer :priority
      t.boolean :completed
      t.references :user
      
      t.timestamps
    end
  end
end

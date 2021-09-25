class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.integer :priority
      t.boolean :completed

      t.timestamps
    end
  end
end

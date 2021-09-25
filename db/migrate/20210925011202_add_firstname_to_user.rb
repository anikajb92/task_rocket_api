class AddFirstnameToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :firstname, :string
  end
end

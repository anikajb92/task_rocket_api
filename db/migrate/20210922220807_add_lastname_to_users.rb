class AddLastnameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :lastname, :string
  end
end

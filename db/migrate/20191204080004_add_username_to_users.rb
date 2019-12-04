class AddUsernameToUsers < ActiveRecord::Migration[6.0]
  ## Workaround:
  ##  sqlite3 is unable to add not nullable column
  ##  without default even on am empty table
  def up
     add_column :users, :username, :string, { :limit => 20 }
     change_column :users, :username, :string, { :null => false }
     add_index :users, :username, { :unique => true }
  end

  def down
    remove_index :users, :username
    remove_column :users, :username
  end
end

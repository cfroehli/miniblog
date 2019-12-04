class AddUserToPost < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :user, foreign_key: true
    change_column :posts, :user_id, :integer, { :null => false }
  end
end

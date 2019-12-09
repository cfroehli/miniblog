class AddProfileToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :blog_url, :string
    add_column :users, :profile, :string, limit: 200
  end
end

class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes, primary_key: [:post_id, :user_id] do |t|
      t.references :post, null:false
      t.references :user, null:false
      t.timestamps
    end
  end
end

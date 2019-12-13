class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows, primary_key: [:follower_id, :followee_id] do |t|
      t.references :follower, foreign_key: {to_table: 'users'}
      t.references :followee, foreign_key: {to_table: 'users'}
      t.timestamps
    end
  end
end

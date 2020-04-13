# frozen_string_literal: true

class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows, primary_key: %i[follower_id followee_id] do |t|
      t.references :follower, foreign_key: { to_table: 'users' }
      t.references :followee, foreign_key: { to_table: 'users' }
      t.timestamps
    end
  end
end

class AddCounters < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.integer :followers_count, default: 0
      t.integer :followees_count, default: 0
      t.integer :likes_count, default: 0
    end

    change_table :posts do |t|
      t.integer :likes_count, default: 0
    end
  end
end

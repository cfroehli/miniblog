# frozen_string_literal: true

class AddProfileToUser < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :blog_url
      t.string :profile, limit: 200
    end
  end
end

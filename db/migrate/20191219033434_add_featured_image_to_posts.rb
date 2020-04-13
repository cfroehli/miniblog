# frozen_string_literal: true

class AddFeaturedImageToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :featured_image, :string
  end
end

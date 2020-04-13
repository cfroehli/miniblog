# frozen_string_literal: true

Cloudinary.config do |config|
  config.url = ENV['CLOUDINARY_URL']
  config.cache_storage = :file
end

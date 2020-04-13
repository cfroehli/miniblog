# frozen_string_literal: true

json.extract! user, :id, :username, :profile, :blog_url
json.url user_url(user, format: :json)

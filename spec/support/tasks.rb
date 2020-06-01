RSpec.configure do |config|
  config.define_derived_metadata(file_path: %r{/spec/tasks/}) do |metadata|
    metadata[:type] = :task
  end

  config.before(:suite) { Rails.application.load_tasks }
end

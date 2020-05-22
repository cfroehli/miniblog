if ENV['COVERAGE']
  SimpleCov.start 'rails' do
    add_filter 'app/channels'
    add_filter 'app/jobs'

    # enable_coverage :branch ## Await fix issues with 0.18
  end
end
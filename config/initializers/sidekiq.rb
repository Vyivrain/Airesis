Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_PROVIDER'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_PROVIDER'] }
end

Sidekiq::Logging.logger = Logger.new(Rails.root.join('log', 'sidekiq.log'), 50, 100.megabytes)

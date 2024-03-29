if Rails.env == 'production'
  Sentry.init do |config|
    config.dsn = 'https://c01dac0399264f18a7da0929ad15df70@o4504611837509632.ingest.sentry.io/4504611838296064'
    config.breadcrumbs_logger = [:active_support_logger, :http_logger]

    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    # We recommend adjusting this value in production.
    config.traces_sample_rate = 1.0
  end
end
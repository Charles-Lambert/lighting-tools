import Config

config :lifx,
  max_api_timeout: 60000,
  max_retries: 10,
  wait_between_retry: 5000
  
#import_config "#{config_env()}.exs"

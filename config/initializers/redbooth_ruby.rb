RedboothRuby.config do |configuration|
  configuration[:consumer_key] = ENV['REDBOOTH_APP_ID']
  configuration[:consumer_secret] = ENV['REDBOOTH_APP_SECRET']
end

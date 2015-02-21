uri = URI.parse(ENV['REDISCLOUD_URL'] || 'redis://127.0.0.1:6379')
REDIS_OPTIONS = {
  host: uri.host,
  port: uri.port,
  password: uri.password,
}
Redis.current = Redis.new(REDIS_OPTIONS)

Warden::Manager.before_failure do |env, opts|
  logger.warn env
  logger.warn opts
  super
end
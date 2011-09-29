
USER_CONF_DIRECTORIES_TO_LOAD_FROM = %w(
  models
  controllers
  views
  helpers
  )

USER_CONF_DIRECTORIES_TO_LOAD_FROM.each do |dir|
  dir.gsub!('/', File::SEPARATOR)
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.autoload_paths << path
  ActiveSupport::Dependencies.autoload_once_paths.delete(path)
end


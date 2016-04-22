source 'https://rubygems.org'

ruby '2.3.0'

gem 'rails', '>= 5.0.0.beta3', '< 5.1'

# Rails plugins
gem 'puma'
gem 'jbuilder', '~> 2.0'
gem 'dotenv-rails', '2.1.0'
gem 's3'
gem 'propono'
gem 'resque', '~> 1.26'
gem 'resque-scheduler'
gem 'sinatra', git: 'http://github.com/sinatra/sinatra', branch: 'master'
gem 'resque-web', require: 'resque_web'
gem 'resque-scheduler-web'

# Assets pipeline
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'autoprefixer-rails'

# Api engine
gem 'cartowrap', path: 'cartowrap'

# Active record
gem 'pg', '~> 0.18'

group :development, :test do
  gem 'teaspoon-mocha', git: 'http://github.com/modeset/teaspoon', branch: 'rails_5'
  gem 'hirb'
  gem 'awesome_print'
  gem 'faker'
  gem 'spring-commands-rspec'
  gem 'rspec-rails', '~> 3.0'

  # Deploy
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'
  gem 'capistrano-passenger'
end

group :development do
  #gem 'spring'
  gem 'web-console', '~> 3.0'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'annotate'
  gem 'quiet_assets'
  gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
end

group :test do
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

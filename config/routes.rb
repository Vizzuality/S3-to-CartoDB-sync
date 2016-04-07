Rails.application.routes.draw do

  require "resque_web"

  S3ToCartodbSync::Application.routes.draw do
    mount ResqueWeb::Engine => "/resque_web"
  end

  # CartoDB pull csv
  get 'downloads/aggregate-data', to: 'cartodb_sync_files#index'

  get 'synchronize', to: 'cartodb_sync_files#new'
  post 'synchronize', to: 'cartodb_sync_files#new'

end

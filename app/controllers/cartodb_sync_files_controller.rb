class CartodbSyncFilesController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    if params[:token] == ENV['CARTODB_SYNC_TOKEN']
      send_file 'public/system/aggregate_data.csv'
    else
      render text: "401 Unauthorized", status: :unauthorized
    end
  end
  def new
    if params[:token] == ENV['CARTODB_SYNC_TOKEN']
      render text: "ok", status: 200
    else
      render text: "401 Unauthorized", status: :unauthorized
    end
  end
end

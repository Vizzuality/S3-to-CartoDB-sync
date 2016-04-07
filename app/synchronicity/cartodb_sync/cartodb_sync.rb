require 'cartodb_sync/cartodb_check'
module Synchronicity
  class CartodbSync

    def initialize(import_id, sync_id)
      @import_id = import_id || ENV["CARTODB_IMPORT_ID"]
      @sync_id = sync_id
    end

    attr_reader :import_id, :sync_id, :enqueued, :cdb_synchronization_id

    def start
      puts "performing"
      api_call = Cartowrap::API.new
      api_call.force_synchronization(import_id)
      synchronization = Synchronization.find(sync_id)
      @enqueued = JSON.parse(api_call.response)["enqueued"]
      @cdb_synchronization_id = JSON.parse(api_call.response)["synchronization_id"]
      synchronization.log = (JSON.parse(synchronization.log).merge!({"cartodb_sync_status" => @enqueued})).to_json
      synchronization.sync_id = @cdb_synchronization_id
      synchronization.sync_at = DateTime.now
      if @enqueued
        synchronization.status = "Internal database up to date. Enqueued synchronization into CartoDB"
        CartodbCheckJob.set(wait_until: DateTime.now + 5.minutes).perform_later(cdb_synchronization_id, sync_id)
      else
        synchronization.status = "Internal database up to date. Failed to enqueue into CartoDB"
      end
      synchronization.save
    end
  end
end

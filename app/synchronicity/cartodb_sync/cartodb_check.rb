module Synchronicity
  class CartodbCheck

    def initialize(cdb_synchronization_id, sync_id)
      @cdb_synchronization_id = cdb_synchronization_id
      @sync_id = sync_id
    end

    attr_reader :sync_id, :state, :cdb_synchronization_id

    def start
      puts "performing"
      api_call = Cartowrap::API.new
      api_call.check_synchronization(cdb_synchronization_id)
      synchronization = Synchronization.find(sync_id)
      @state = JSON.parse(api_call.response)["state"]
      synchronization_log = JSON.parse(synchronization.log)
      synchronization_log["cartodb_sync_status"] = @state
      synchronization.log = synchronization_log.to_json
      if @state == "success"
        synchronization.status = "Internal database up to date. CartoDB up to date. Success!"
        synchronization.sync_at = DateTime.now
      elsif @state == 'failure'
        synchronization.status = "Internal database up to date. CartoDB failed to sync. Failure!"
        synchronization.sync_at = DateTime.now
      else
        CartodbCheckcJob.set(wait_until: Time.now + 5.minutes).perform_later(cdb_synchronization_id, sync_id)
        synchronization.status = "Internal database up to date. CartoDB: #{@state}"
      end
      synchronization.save
    end
  end
end

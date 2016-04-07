require 's3_proxy/s3_proxy'
require 'data_management/importer'
require 'data_management/exporter'
require 'pubsub/listener'
require 'cartodb_sync/cartodb_sync'

# Synchronices S3 files with Postgre DB and CartoDB
module Synchronicity

  # pull for new files uploaded to S3
  def self.sync
    synchronization = Synchronization.create(date: Time.now.in_time_zone, status: 'initializing', log: 'Failed importing files from S3, please, review file names and formats')
    synchronization_log = OpenStruct.new(id: synchronization.id)
    import_errors = []
    imported_rows = []
    s3 = S3Proxy.new
    files = s3.get_files
    files.each do |f|
      importer = Importer.new(f.temporary_url)
      importer.import
      import_errors << {file_name: f.key, errors: importer.errors} if importer.errors.size > 0
      imported_rows << {file_name: f.key, imported_rows: importer.imported_rows}
      s3.backup(f)
    end
    if import_errors && import_errors.to_a.size > 0
      synchronization_log.import_status = 'Done with errors'
      synchronization_log.import_errors = import_errors
    else
      synchronization_log.import_status = 'Done without errors'
      synchronization_log.import_status = 'Records imported to local database'
    end
    synchronization_log.imported_rows = imported_rows
    synchronization.log = synchronization_log.marshal_dump.to_json
    if total_imported_rows(imported_rows) > 0
      exporter = Exporter.new
      exporter.export
      last_synchronization = Synchronization.order('sync_at DESC').where.not(id: synchronization.id, sync_at: nil).first&.sync_at || DateTime.now - 17.minutes
      if last_synchronization + 16.minutes > DateTime.now
         time_to_wait = last_synchronization + 16.minutes
      else
        time_to_wait = DateTime.now + 1.seconds
      end
      if Resque.get_last_enqueued_at(CartodbSyncJob) == nil
        synchronization.status = "Records imported. Begin synchronization with CartoDB"
        CartodbSyncJob.set(wait_until: time_to_wait).perform_later(ENV["CARTODB_IMPORT_ID"], synchronization.id)
      else
        synchronization.status = "Records imported. There is a pending synchronization job. Cartodb will get updated."
      end
    else
      synchronization.status = "Nothing changed"
    end
    synchronization.save!
  end

  def self.listen(topic=nil)
    topic = topic || ENV["SNS_TOPIC"]
    listener = Listener.new(topic)
    listener.listen
  end

  private

  def self.total_imported_rows(json)
    total = json.map{|j| j[:imported_rows].to_i}.reduce(:+)
    total
  end

end

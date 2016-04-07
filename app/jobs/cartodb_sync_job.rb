class CartodbSyncJob < ApplicationJob
  queue_as = :default

  def perform(*args)
    sync = Synchronicity::CartodbSync.new(args[0], args[1])
    sync.start
  end
end

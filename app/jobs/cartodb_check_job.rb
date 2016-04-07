class CartodbCheckJob < ApplicationJob
  queue_as = :default

  def perform(*args)
    check = Synchronicity::CartodbCheck.new(args[0], args[1])
    check.start
  end
end

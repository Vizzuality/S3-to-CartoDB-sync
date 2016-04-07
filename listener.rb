Propono.listen_to_queue(:s3pub) do |message|
  p message
  Synchronicity.sync
end

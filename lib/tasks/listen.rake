namespace :synchronicity do
  desc "Starts listening for changes in S3"
  task listen: :environment do
    #sh "bundle exec ruby app/synchronicity/pubsub/listener.rb"
    Propono.listen_to_queue(:s3pub) do |message|
      p message
      Synchronicity.sync
    end
  end
end

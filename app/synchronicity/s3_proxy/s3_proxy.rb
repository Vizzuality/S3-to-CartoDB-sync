module Synchronicity
  class S3Proxy
    def initialize
      @service = S3::Service.new(access_key_id: ENV["AMAZON_ACCESS_KEY_ID"], secret_access_key: ENV["AMAZON_SECRET_ACCESS_KEY"])
    end
    attr_reader :service

    # get CSV files from S3
    def get_files
      bucket = service.buckets.find(ENV["S3_BUCKET_NAME"])
      keys = bucket.objects.map(&:key)
      file_names = keys.map{|k| k.match(/upload\/.+\.csv/) ? k : nil}.reject(&:nil?)
      files = file_names.map{|f| bucket.objects.find(f)}
      files
    end

    # moves file from upload to backup folder
    def backup(csv_file)
      puts csv_file.key
      csv_file.copy(key: csv_file.key.gsub("upload", "backup"))
      csv_file.destroy
    end

  end
end

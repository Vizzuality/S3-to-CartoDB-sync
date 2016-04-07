require 'csv'
require 'open-uri'
require 'data_management/csv_validator'
module Synchronicity
  class Importer

    def initialize(file)
      @file = file
      @errors = []
    end

    attr_reader :file, :errors, :imported_rows

    def import
      csv = CSV.parse(open(file).read(), :headers => true)
      validator = Synchronicity::CsvValidator.new(csv)
      unless validator.valid
        @errors = validator.errors
        return
      end
      new_hash = {}
      i = 1
      @imported_rows = 0
      csv.each do |row|
        i += 1
        row.to_hash.each_pair do |k,v|
          new_hash.merge!({k.downcase => v})
        end
        value_object = ValueObject.new(new_hash)
        if value_object.valid?
          uid = value_object.generate_uid
          ValueObject.where(uid: uid).update_or_create(new_hash)
          @imported_rows += 1
        else
          @errors << value_object.errors.messages.merge({line: i})
        end
      end
    end
  end
end


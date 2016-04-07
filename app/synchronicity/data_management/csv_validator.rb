module Synchronicity
    class CsvValidator
      def initialize(csv)
        @errors = []
        @csv = csv
      end

      attr_reader :errors, :valid

      def valid
        @errors << "Malformed headers in CSV" unless valid_headers?
        @errors << "Malformed body in CSV" unless valid_body?
        @errors.length == 0 ? true : false
      end

      private

      def valid_headers?
        if
        (@csv.headers.map{|h| (h != nil && Synchronization::HEADERS.include?(h.downcase)) ? true : false}.include?(false)) ||
        (@csv.headers.detect{ |e| @csv.count(e) > 1 } != nil) ||
        (@csv.headers.size != Synchronization::HEADERS.size)
          return false
        else
          return true
        end
      end

      def valid_body?
        @csv.each do |row|
          row.to_hash.each_pair do |k,v|
            return false if !k || row.size != Synchronization::HEADERS.size
          end
        end
      end

    end
end

module Synchronicity
  class Exporter

    def initialize
    end

    def export
      path = Rails.root.join('public', 'system', 'aggregate_data.csv').to_s
      query = "COPY value_objects TO '#{path}' DELIMITER ',' CSV HEADER;"
      ValueObject.connection.execute(query)
    end
  end
end


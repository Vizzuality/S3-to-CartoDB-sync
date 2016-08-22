module Synchronicity
  class Exporter

    def initialize
    end

    def export
      path = Rails.root.join('public', 'system', 'aggregate_data.csv').to_s
      query = "COPY (select * from value_objects order by created_at desc) TO '#{path}' DELIMITER ',' CSV HEADER;"
      ValueObject.connection.execute(query)
    end
  end
end


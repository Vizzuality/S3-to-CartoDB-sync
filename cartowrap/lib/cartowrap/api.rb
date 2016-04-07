module Cartowrap
  class API
    def initialize(api_key = nil, account = nil)
      @api_key = api_key || Cartowrap.config.api_key
      @account = account || Cartowrap.config.account
      @credentials = {}
      @credentials['api_key'] = @api_key
      @credentials['account'] = @account
      @options = OpenStruct.new
    end

    attr_reader :api_key, :account, :credentials, :options, :response

    def send_query(query)
      options.endpoint = "sql"
      options.query_string = true
      options.q = query
      result = make_call(options)
      result
    end

    def get_synchronizations
      options.endpoint = "import"
      options.query_string = false
      result = make_call(options)
      result
    end

    def get_synchronization(import_id)
      options.endpoint = "import"
      options.import_id = import_id
      options.query_string = false
      options.http_method = 'get'
      result = make_call(options)
      result
    end

    def check_synchronization(import_id)
      options.endpoint = "import"
      options.query_string = false
      options.http_method = 'get'
      options.resource_id = "#{import_id}/sync_now"
      result = make_call(options)
      result
    end

    def force_synchronization(import_id)
      options.endpoint = "import"
      options.query_string = false
      options.http_method = 'put'
      options.resource_id = "#{import_id}/sync_now"
      result = make_call(options)
      result
    end

    def create_synchronization(url, interval, sync_options={})
      validate_sync_options(sync_options) if sync_options
      options.endpoint = "import"
      options.type_guessing = sync_options[:type_guessing]
      options.quoted_fields_guessing = sync_options[:quoted_fields_guessing]
      options.content_guessing = sync_options[:content_guessing]
      options.query_string = false
      options.url = url
      options.interval = interval
      options.http_method = 'post'
      result = make_call(options)
      result
    end

    def delete_synchronization(import_id)
      options.endpoint = "import"
      options.resource_id = import_id
      options.query_string = false
      options.http_method = 'delete'
      result = make_call(options)
      result
    end

    def initialize_options
      @options = OpenStruct.new
    end

    private

    def validate_sync_options(sync_options)
      valid_options = [:type_guessing, :quoted_fields_guessing, :content_guessing]
      sync_options = sync_options.map{|o| ((valid_options.include? o[0]) && !!o[1] == o[1]) ? o : nil}.compact.to_h
      sync_options
    end

    def make_call(options)
      result = Cartowrap.make_request(options, credentials)
      unless check_errors(result.status.to_i, result.body)
        MultiJson.load("[#{result.body.to_s}]")[0]
      end
      initialize_options
      @response = result.body
    end

    def check_errors(status, body)
      case status
      when 500
        initialize_options
        raise Cartowrap::ServerError.new(status, '')
      when 401
        initialize_options
        raise Cartowrap::NoTokenError.new(status, body)
      when 404
        initialize_options
        raise Cartowrap::NotFoundError.new(status, '')
      else
        return false
      end
    end
  end
end

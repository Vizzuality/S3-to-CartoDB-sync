require 'spec_helper'
require 'rails_helper'

describe Cartowrap::APIError do
  it "is a Cartowrap::CartowrapError" do
    expect(Cartowrap::APIError.new(nil, nil)).to be_a(Cartowrap::CartowrapError)
  end

  [:cdb_error_type, :cdb_error_code, :cdb_error_subcode, :cdb_error_message, :cdb_error_user_msg, :cdb_error_user_title, :http_status, :response_body].each do |accessor|
    it "has an accessor for #{accessor}" do
      expect(Cartowrap::APIError.instance_methods.map(&:to_sym)).to include(accessor)
      expect(Cartowrap::APIError.instance_methods.map(&:to_sym)).to include(:"#{accessor}=")
    end
  end

  it "sets http_status to the provided status" do
    error_response = '{ "error": {"type": "foo", "other_details": "bar"} }'
    expect(Cartowrap::APIError.new(400, error_response).response_body).to eq(error_response)
  end

  it "sets response_body to the provided response body" do
    expect(Cartowrap::APIError.new(400, '').http_status).to eq(400)
  end

  context "with an error_info hash" do
    let(:error) {
      error_info = {
        'type' => 'type',
        'message' => 'message',
        'code' => 1,
        'error_subcode' => 'subcode',
        'error_user_msg' => 'error user message',
        'error_user_title' => 'error user title'
      }
      Cartowrap::APIError.new(400, '', error_info)
    }

    {
      :cdb_error_type => 'type',
      :cdb_error_message => 'message',
      :cdb_error_code => 1,
      :cdb_error_subcode => 'subcode',
      :cdb_error_user_msg => 'error user message',
      :cdb_error_user_title => 'error user title'
    }.each_pair do |accessor, value|
      it "sets #{accessor} to #{value}" do
        expect(error.send(accessor)).to eq(value)
      end
    end

    it "sets the error message appropriately" do
      expect(error.message).to eq("type: type, code: 1, error_subcode: subcode, message: message, error_user_title: error user title, error_user_msg: error user message [HTTP 400]")
    end
  end

  context "with an error_info string" do
    it "sets the error message \"error_info [HTTP http_status]\"" do
      error_info = "Cartodb is down."
      error = Cartowrap::APIError.new(400, '', error_info)
      expect(error.message).to eq("Cartodb is down. [HTTP 400]")
    end
  end

  context "with no error_info and a response_body containing error JSON" do
    it "should extract the error info from the response body" do
      response_body = '{ "error": { "type": "type", "message": "message", "code": 1, "error_subcode": "subcode", "error_user_msg": "error user message", "error_user_title": "error user title" } }'
      error = Cartowrap::APIError.new(400, response_body)
      {
        :cdb_error_type => 'type',
        :cdb_error_message => 'message',
        :cdb_error_code => 1,
        :cdb_error_subcode => 'subcode',
        :cdb_error_user_msg => 'error user message',
        :cdb_error_user_title => 'error user title'
      }.each_pair do |accessor, value|
        expect(error.send(accessor)).to eq(value)
      end
    end
  end

end

describe Cartowrap::CartowrapError do
  it "is a StandardError" do
     expect(Cartowrap::CartowrapError.new).to be_a(StandardError)
  end
end

describe Cartowrap::BadCartodbResponse do
  it "is a Cartowrap::APIError" do
     expect(Cartowrap::BadCartodbResponse.new(nil, nil)).to be_a(Cartowrap::APIError)
  end
end

describe Cartowrap::OAuthTokenRequestError do
  it "is a Cartowrap::APIError" do
     expect(Cartowrap::OAuthTokenRequestError.new(nil, nil)).to be_a(Cartowrap::APIError)
  end
end

describe Cartowrap::ServerError do
  it "is a Cartowrap::APIError" do
     expect(Cartowrap::ServerError.new(nil, nil)).to be_a(Cartowrap::APIError)
  end
end

describe Cartowrap::ClientError do
  it "is a Cartowrap::APIError" do
     expect(Cartowrap::ClientError.new(nil, nil)).to be_a(Cartowrap::APIError)
  end
end

describe Cartowrap::AuthenticationError do
  it "is a Cartowrap::ClientError" do
     expect(Cartowrap::AuthenticationError.new(nil, nil)).to be_a(Cartowrap::ClientError)
  end
end

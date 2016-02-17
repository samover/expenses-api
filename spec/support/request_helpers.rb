module Request
  module JsonHelpers
    def json_response
      @json_response || JSON.parse(response.body, symbolize_names: true)
    end
  end
  module HeadersHelpers
    def api_header version=1
      request.headers['Accept'] = "application/vnd.accounts.v#{version}"
    end

    def api_response_format format=Mime::JSON
      request.headers['Accept'] = "#{request.headers['Accept']}, #{format}"
      request.headers['Content-type'] = format.to_s
    end
    
    def api_request_token token=FactoryGirl.create(:user).auth_token
      request.headers['Authorization'] = "Token token=#{token}"
    end

    def include_default_accept_headers
      api_header
      api_response_format
      api_request_token
    end
  end
end

class RestApi
  attr_accessor :client

  def initialize(root_url: "", headers: {})
    @client = Faraday.new(
      url: root_url,
    )
  end

  def get(endpoint: "", headers: {}, url_params: {}, body: {})
    response = @client.get("#{endpoint}") do |req|
      req.params = url_params
      req.headers = headers
    end

    json_body(response)
  end

  def put(endpoint: "", headers: {}, url_params: {}, body: {})
    response = @client.put(endpoint) do |req|
      req.headers.merge!(headers)
      req.body = body.to_json
    end
  end

  def patch(endpoint: "", headers: {}, url_params: {}, body: {})
    response = @client.patch(endpoint) do |req|
      req.headers.merge!(headers)
      req.body = body.to_json
    end
  end

  def post(endpoint: "", headers: {}, url_params: {}, body: {})
    response = @client.post(endpoint) do |req|
      req.headers.merge!(headers)
      req.body = body.to_json
    end
  end

  def delete(endpoint: "", headers: {}, url_params: {})
    response = @client.delete("#{endpoint}") do |req|
      req.params = url_params
      req.headers = headers
    end
  end

  def json_body(response)
    JSON.parse(response.body)
  end
end

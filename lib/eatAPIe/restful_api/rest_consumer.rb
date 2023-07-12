require "yaml"
require "pry"

module EatAPIe
  module RestfulApi
    class RestConsumer
      def initialize(name)
        # parse and load restful_eatAPIes.yml
        return false unless @apis = YAML.load_file("restful_eatAPIes.yml")[name]

        @api_key = @apis["api_key"]
        @content_type = @apis["content_type"]
        @auth_header = @apis["auth_header"]
        @client = EatAPIe::RestfulApi::RestApi.new(root_url: @apis["root_url"])

        @apis["endpoints"].each do |action, endpoints|
          case action
          when "GET"
            endpoints.each do |method, endpoint|
              define_singleton_method method do |args = {}|
                @client.get(endpoint: formatted_endpoint(endpoint, args), headers: headers, url_params: args["url_params"], body: args["body"])
              end
            end
          when "POST"
            endpoints.each do |method, endpoint|
              define_singleton_method method do |args = {}|
                @client.post(endpoint: formatted_endpoint(endpoint, args), headers: headers, body: args["body"])
              end
            end
          when "PUT"
            endpoints.each do |method, endpoint|
              define_singleton_method method do |args = {}|
                @client.put(endpoint: formatted_endpoint(endpoint, args), headers: headers, body: args["body"])
              end
            end
          when "PATCH"
            endpoints.each do |method, endpoint|
              define_singleton_method method do |args = {}|
                @client.patch(endpoint: formatted_endpoint(endpoint, args), headers: headers, body: args["body"])
              end
            end
          when "DELETE"
            endpoints.each do |method, endpoint|
              define_singleton_method method do |args = {}|
                @client.patch(endpoint: formatted_endpoint(endpoint, args), headers: headers, body: args["body"])
              end
            end
          end
        end
      end

      def formatted_endpoint(endpoint = "", args = {})
        endpoint.scan(/{(\w*?)}/).flatten.each do |param|
          endpoint.gsub!(/\{#{param}\}/, args[param.to_sym].to_s) if args[param.to_sym]
        end

        endpoint
      end

      def headers
        { 'Content-Type': @content_type, 'Authorization': @auth_header, "User-Agent" => "Faraday v1.0.1" }
      end
    end
  end
end

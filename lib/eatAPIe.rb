# frozen_string_literal: true

require "dotenv/load"
require_relative "eatAPIe/version"
require_relative "eatAPIe/restful_api/rest_api"
require_relative "eatAPIe/restful_api/rest_consumer"

module EatAPIe
  class Error < StandardError; end

  # Your code goes here...
end

# frozen_string_literal: true

module HiEnergyApi
  class Paginator
    include Enumerable

    def initialize(client:, path:, params: {}, first_response: nil)
      @client = client
      @path = path
      @params = params
      @first_response = first_response
    end

    def each
      response = @first_response || @client.get(@path, params: @params)

      loop do
        yield response

        break unless response.has_more?

        next_params = @params.merge(response.next_page_params)
        response = @client.get(@path, params: next_params)
      end
    end
  end
end

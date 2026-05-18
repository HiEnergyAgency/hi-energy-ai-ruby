# frozen_string_literal: true

module HiEnergyApi
  module Resources
    class Clicks < Resource
      def list(start_date:, end_date:, **params)
        get("/clicks", params: params.merge(start_date: start_date, end_date: end_date))
      end
    end
  end
end

# frozen_string_literal: true

module HiEnergyAi
  module Resources
    class StatusChanges < Resource
      def list(**params)
        get("/status_changes", params: params)
      end
    end
  end
end

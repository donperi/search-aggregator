# frozen_string_literal: true

module WebSearcher
  module Providers

    # Google Module
    module Google
      # Perform a bing web search
      #
      # @param [String] term
      # @param [Integer] offset
      # @return [Response]
      def self.call(term, offset = 0)
        Search.call(term, offset)
      end
    end
  end
end

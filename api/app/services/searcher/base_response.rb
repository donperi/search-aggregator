# frozen_string_literal: true

module Searcher
  # Base Response Object
  class BaseResponse
    attr_reader :search_result

    # @param [Hash] search_result - Parsed JSON from the web search result.
    def initialize(search_result)
      @search_result = search_result
    end

    # Returns array of items from the search_result
    #
    # @return [Array<Hash>]
    def results
      raise NotImplementedError
    end

    def items
      @items ||= begin
        results.map do |record|
          self.class.module_parent::ResultItem.new(record)
        end
      end
    end

    def total
      items.length
    end

    delegate :each, :[], :map, :reduce, :select, :find, to: :items
  end
end

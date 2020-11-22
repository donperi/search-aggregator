# frozen_string_literal: true

module Searcher
  # Base Search class for each engine.
  class BaseSearch
    attr_reader :term, :offset, :cache

    # @param [String] term
    # @param [Integer] offset
    # @return [Searcher::BaseResponse]
    def initialize(term, offset = 0, cache: true)
      @term = term
      @offset = offset
      @cache = cache
    end

    # Perform a web search
    #
    # @param [String] term
    # @param [Integer] offset
    # @return [Searcher::BaseResponse]
    def self.call(term = '', offset = 0, cache: true)
      new(term, offset, cache: cache).call
    end

    def call
      search_proc = -> { self.class.module_parent::Response.new(search_response) }

      if cache
        @call ||= Rails.cache.fetch(cache_key, namespace: 'searcher', expires_in: 1.day) do
          search_proc.call
        end
      end

      @call ||= search_proc.call
    end

    # @return [Symbol] - Name identifier for the search class
    def name
      raise NotImplementedError
    end

    def search_response
      @search_response ||= JSON.parse(HTTParty.get(
        self.class::SEARCH_URL,
        query: query,
        headers: headers,
        format: :json
      ).body)
    end

    private

    def cache_key
      "#{name}/#{term.gsub('/', '_')}/#{offset}"
    end

    def headers
      {}
    end
  end
end

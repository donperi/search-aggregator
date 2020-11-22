# frozen_string_literal: true

module Searcher

  def self.engines_map
    @engines_map ||= {
      google: Providers::Google::Search,
      bing: Providers::Bing::Search
    }.freeze
  end

  # Perform a web search to the provided engines
  #
  # @param [String] term
  # @param [Integer] offset
  # @param [Array<String>|Array<Symbol>|Symbol|String] engines
  # @return [Searcher::Result]
  def self.call(term:, offset:, engines: [])
    responses = Array(engines).map do |engine|
      return nil if engines_map[engine.to_sym].nil?

      engines_map[engine.to_sym].call(term, offset, cache: true)
    end.compact

    Result.new(responses)
  end
end

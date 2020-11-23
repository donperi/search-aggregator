# frozen_string_literal: true

module WebSearcher

  def self.providers_map
    @providers_map ||= {
      google: Providers::Google::Search,
      bing: Providers::Bing::Search
    }.freeze
  end

  # Perform a web search to the provided engines
  #
  # @param [String] term
  # @param [Integer] offset
  # @param [Array<String>|Array<Symbol>|Symbol|String] engines
  # @return [WebSearcher::Result]
  def self.call(term:, offset:, providers: [])
    result = Result.new

    Array(providers).each do |provider|
      return nil if providers_map[provider.to_sym].nil?

      begin
        result.responses << providers_map[provider.to_sym].call(term, offset, cache: true)
      rescue StandardError => e
        result.add_provider_error(provider, e.message)
      end
    end.compact

    result
  end
end

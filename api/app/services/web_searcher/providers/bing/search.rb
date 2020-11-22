# frozen_string_literal: true

module WebSearcher
  module Providers
    module Bing

      # Search class for google
      class Search < ::WebSearcher::BaseSearch
        SEARCH_URL = 'https://api.bing.microsoft.com/v7.0/search'

        def name
          :bing
        end

        def query
          { q: term,offset: offset }
        end

        def access_token
          ENV['BING_SEARCH_KEY'] or raise('Bing Key missing.')
        end

        def headers
          {
            'Ocp-Apim-Subscription-Key' => access_token
          }
        end
      end
    end
  end
end

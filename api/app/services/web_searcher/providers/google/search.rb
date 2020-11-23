# frozen_string_literal: true

module WebSearcher
  module Providers
    module Google

      # Search class for google
      class Search < ::WebSearcher::BaseSearch
        SEARCH_URL = 'https://www.googleapis.com/customsearch/v1'

        def name
          :google
        end

        def access_token
          raise('Google Search Key missing') if ENV['GOOGLE_SEARCH_KEY'].blank?

          ENV['GOOGLE_SEARCH_KEY'] or raise('Google Search Key missing')
        end

        def search_custom_engine
          raise('Google Custom Engine missing') if ENV['GOOGLE_CUSTOM_ENGINE'].blank?

          ENV['GOOGLE_CUSTOM_ENGINE']
        end

        def query
          {
            q: term,
            start: offset + 1,
            cx: search_custom_engine,
            key: access_token
          }
        end
      end
    end
  end
end

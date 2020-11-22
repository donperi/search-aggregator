# frozen_string_literal: true

module WebSearcher
  module Providers
    module Bing

      # Maps single result html into object
      class ResultItem < ::WebSearcher::BaseResultItem
        def source
          :bing
        end

        def title
          result_object['name']
        end

        def description
          result_object['snippet']
        end

        def url
          result_object['displayUrl']
        end
      end
    end
  end
end

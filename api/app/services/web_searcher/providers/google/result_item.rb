# frozen_string_literal: true

module WebSearcher
  module Providers
    module Google
      class ResultItem < ::WebSearcher::BaseResultItem
        def source
          :google
        end

        def title
          result_object['title']
        end

        def description
          result_object['snippet']
        end

        def url
          result_object['link']
        end
      end
    end
  end
end

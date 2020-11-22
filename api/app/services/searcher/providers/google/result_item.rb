# frozen_string_literal: true

module Searcher
  module Providers
    module Google
      class ResultItem < ::Searcher::BaseResultItem
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

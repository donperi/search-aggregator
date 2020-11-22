# frozen_string_literal: true

module WebSearcher
  module Providers
    module Bing
      # Google Response
      class Response < ::WebSearcher::BaseResponse
        def results
          search_result['webPages']['value']
        end
      end
    end
  end
end

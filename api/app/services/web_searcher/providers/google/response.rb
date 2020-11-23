# frozen_string_literal: true

module WebSearcher
  module Providers
    module Google
      # Google Response
      class Response < ::WebSearcher::BaseResponse
        def results
          search_result['items'] || []
        end
      end
    end
  end
end

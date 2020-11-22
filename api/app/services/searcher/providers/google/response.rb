# frozen_string_literal: true

module Searcher
  module Providers
    module Google
      # Google Response
      class Response < ::Searcher::BaseResponse
        def results
          search_result['items']
        end
      end
    end
  end
end

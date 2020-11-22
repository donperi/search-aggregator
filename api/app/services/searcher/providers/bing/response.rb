# frozen_string_literal: true

module Searcher
  module Providers
    module Bing
      # Google Response
      class Response < ::Searcher::BaseResponse
        def results
          search_result['webPages']['value']
        end
      end
    end
  end
end

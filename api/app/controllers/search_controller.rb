# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    if search_params.invalid?
      return render status: :bad_request, json: {
        status: 400,
        errors: search_params.errors
      }
    end

    @result = Searcher.call(
      term: search_params.term,
      offset: search_params.offset,
      engines: search_params.engines
    )
  end

  def search_params
    @search_params ||= SearchParams.new(term: params[:term], engines: params[:engines], offset: params[:offset])
  end
end

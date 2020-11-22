# frozen_string_literal: true

module Searcher

  # Hello
  class BaseResultItem
    attr_reader :result_object
    attr_writer :source, :title, :description, :url, :image

    # @param [Hash] result_object - Hash representation of web result item
    def initialize(result_object)
      @result_object = result_object
    end

    # @return [Symbol]
    def source
      @source or raise NotImplementedError
    end

    # @return [String]
    def title
      @title or raise NotImplementedError
    end

    # @return [String]
    def description
      @description or raise NotImplementedError
    end

    # @return [String]
    def url
      @url or raise NotImplementedError
    end
  end
end


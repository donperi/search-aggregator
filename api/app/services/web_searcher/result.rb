# frozen_string_literal: true

module WebSearcher

  # Result object from a search
  class Result
    attr_reader :responses

    def initialize(responses)
      @responses = Array(responses)
      @total = 0
    end

    def items
      @items ||= begin
        (0..max_num_items).each_with_object([]) do |order, carry|
          responses.length.times do |response_index|
            item = responses[response_index].items[order]

            carry.push(item) if item.present?
          end
        end
      end
    end

    def total
      items.length
    end

    delegate :each, :[], :map, :reduce, :select, :find, to: :items

    private

    def max_num_items
      @max_num_items ||= responses.inject(0) do |max, response|
        max = response.items.length if max < response.items.length

        max
      end
    end
  end
end

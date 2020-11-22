# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebSearcher::Result do
  describe '#items' do
    it 'should return all the results from all the responses in the response item order' do
      responses = [
        double(items: [1, 3, 5]),
        double(items: [2, 4, 6])
      ]

      result = described_class.new(responses)

      expect(result.items).to eq([1, 2, 3, 4, 5, 6])
    end
  end
end

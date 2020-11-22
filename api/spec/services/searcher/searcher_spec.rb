# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Searcher do
  describe '#call' do
    it 'should call Search with multiple engines' do
      VCR.use_cassette('searcher_ruby_google_bing') do
        result = described_class.call(
          term: 'ruby',
          offset: 0,
          engines: %i[google bing]
        )

        expect(result.items.length).to eq(20)
        expect(result.total).to eq(20)
      end
    end

    it 'should call Search with single engine' do
      VCR.use_cassette('searcher_ruby_google') do
        result = described_class.call(
          term: 'ruby',
          offset: 0,
          engines: %i[google]
        )

        expect(result.items.length).to eq(10)
        expect(result.total).to eq(10)
      end
    end
  end
end

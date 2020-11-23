# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebSearcher do
  describe '#call' do
    it 'should call Search with multiple engines' do
      VCR.use_cassette('searcher_ruby_google_bing') do
        result = described_class.call(
          term: 'ruby',
          offset: 0,
          providers: %i[google bing]
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
          providers: %i[google]
        )

        expect(result.items.length).to eq(10)
        expect(result.errors.length).to eq(0)
        expect(result.total).to eq(10)
      end
    end

    it 'should add error message if provider call fails' do
      allow(WebSearcher::Providers::Google::Search).to receive(:call).and_raise(StandardError.new('provider error'))

      result = described_class.call(
        term: 'ruby',
        offset: 0,
        providers: %i[google]
      )

      expect(result.items.length).to eq(0)
      expect(result.errors.length).to eq(1)
      expect(result.errors).to eq({
                                    google: ['provider error'],
                                  })
      expect(result.total).to eq(0)

    end
  end
end

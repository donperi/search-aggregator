# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Searcher::Providers::Google::Response do
  let(:search_response) do
    search = Searcher::Providers::Google::Search.new('ruby', 0)
    search.search_response
  end

  subject { described_class.new(search_response) }

  describe '#total' do
    it('should return total objects in the response') do
      VCR.use_cassette('searcher_ruby_google') do
        expect(subject.total).to eq(10)
      end
    end

    it('should return collection of ResponseItems') do
      VCR.use_cassette('searcher_ruby_google') do
        subject.map do |result|
          expect(result).to be_instance_of(Searcher::Providers::Google::ResultItem)
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Searcher::Providers::Google::Search do
  let(:search_term) { 'ruby' }
  let(:offset) { 0 }

  subject { described_class.new(search_term, offset) }

  describe '#query' do
    it 'should build a valid query aparams' do
      allow(subject).to receive(:access_token) { 'TOKEN' }
      allow(subject).to receive(:search_custom_engine) { 'ENGINE' }

      expect(subject.query).to eq({
                                    q: search_term,
                                    start: offset + 1,
                                    key: 'TOKEN',
                                    cx: 'ENGINE',
                                  })
    end
  end

  describe '#call' do
    it 'should request google search engine with correct url' do
      httparty_mock = double(body: '{}')
      allow(HTTParty).to receive(:get) { httparty_mock }

      allow_any_instance_of(described_class).to receive(:access_token) { 'TOKEN' }
      allow_any_instance_of(described_class).to receive(:search_custom_engine) { 'ENGINE' }


      expect(HTTParty).to receive(:get).with('https://www.googleapis.com/customsearch/v1', {
                                               format: :json,
                                               headers: {},
                                               query: {
                                                 key: 'TOKEN',
                                                 cx: 'ENGINE',
                                                 q: search_term,
                                                 start: offset + 1
                                               }
                                             })

      described_class.call(search_term, offset)
    end

    it 'should return Response object' do
      VCR.use_cassette('searcher_ruby_google') do
        expect(subject.call).to be_instance_of(Searcher::Providers::Google::Response)
      end
    end
  end
end

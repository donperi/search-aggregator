# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebSearcher::Providers::Bing::Search do
  let(:search_term) { 'ruby' }
  let(:offset) { 0 }

  subject { described_class.new(search_term, offset) }

  describe '#query' do
    it 'should build a valid query aparams' do
      expect(subject.query).to eq({ q: search_term, offset: offset })
    end
  end

  describe '#headers' do
    it 'should build a valid header aparams' do
      allow(subject).to receive(:access_token) { 'TOKEN' }
      expect(subject.headers).to eq({ 'Ocp-Apim-Subscription-Key' => 'TOKEN' })
    end
  end

  describe '#call' do
    it 'should request bing search engine with correct url' do
      httparty_mock = double(body: '{}')

      allow(HTTParty).to receive(:get) { httparty_mock }

      allow_any_instance_of(described_class).to receive(:access_token) { 'TOKEN' }

      expect(HTTParty).to receive(:get).with('https://api.bing.microsoft.com/v7.0/search', {
                                               format: :json,
                                               query: {
                                                 q: search_term,
                                                 offset: offset
                                               },
                                               headers: {
                                                 'Ocp-Apim-Subscription-Key' => 'TOKEN'
                                               }
                                             })

      described_class.call(search_term, offset)
    end

    it 'should return Response object' do
      VCR.use_cassette('searcher_ruby_bing') do
        expect(subject.call).to be_instance_of(WebSearcher::Providers::Bing::Response)
      end
    end
  end
end

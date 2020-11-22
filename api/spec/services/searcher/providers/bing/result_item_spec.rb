# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Searcher::Providers::Bing::ResultItem do
  let(:object) do
    JSON.parse(File.read(Rails.root.join('spec', 'fixtures', 'bing_result_item.json')))
  end

  subject { described_class.new(object) }

  describe 'title' do
    it('should map node to title') do
      expect(subject.title).to eq('Ruby Programming Language')
    end
  end

  describe 'description' do
    it('should map node to description') do
      expect(subject.description).to eq("Other News. Support of Ruby 2.4 has ended Posted by usa on 5 Apr 2020; Ruby 2.7.1 Released Posted by naruse on 31 Mar 2020; Ruby 2.6.6 Released Posted by nagachika on 31 Mar 2020")
    end
  end

  describe 'url' do
    it('should map node to url') do
      expect(subject.url).to eq('https://www.ruby-lang.org/en')
    end
  end
end

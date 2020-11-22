# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebSearcher::Providers::Google::ResultItem do
  let(:object) do
    JSON.parse(File.read(Rails.root.join('spec', 'fixtures', 'google_result_item.json')))
  end

  subject { described_class.new(object) }

  describe 'title' do
    it('should map node to title') do
      expect(subject.title).to eq('Ruby Programming Language')
    end
  end

  describe 'description' do
    it('should map node to description') do
      expect(subject.description).to eq("Ruby is... A dynamic, open source programming language with a focus on \nsimplicity and productivity. It has an elegant syntax that is natural to read and \neasy to ...")
    end
  end

  describe 'url' do
    it('should map node to url') do
      expect(subject.url).to eq('https://www.ruby-lang.org/en/')
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchParams do
  describe 'term' do
    it 'should add error if term empty' do
      params = described_class.new(term: '', engines: 'google')

      expect(params.valid?).to be_falsey
      expect(params.errors[:term].length).to be >= 1
    end
  end

  describe 'engine' do
    it 'should return remove invalid engines' do
      params = described_class.new(term: 'ruby', engines: %w[invalid google bing])

      expect(params.valid?).to be_truthy
      expect(params.engines).to eq(%i[google bing])
    end

    it 'should cast string engine into array' do
      params = described_class.new(term: 'ruby', engines: 'google')

      expect(params.valid?).to be_truthy
      expect(params.engines).to eq([:google])
    end

    it 'should add error if engines are empty' do
      params = described_class.new(term: 'ruby', engines: ['invalid'])

      expect(params.valid?).to be_falsey
      expect(params.errors[:engines].length).to be >= 1
    end
  end
end

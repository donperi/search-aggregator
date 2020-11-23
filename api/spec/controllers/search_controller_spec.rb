# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  render_views

  before do
    request.accept = 'application/json'
  end

  describe 'GET find' do
    it 'returns a 200' do
      VCR.use_cassette('searcher_google_ruby') do
        get :index, {
          params: {
            term: 'ruby',
            engines: ['google']
          }
        }

        json_response = JSON.parse(response.body)

        expect(json_response['items'].length).to be(10)
        expect(json_response['errors'].keys.length).to be(0)
        expect(json_response['total']).to be(10)

        expect(response).to have_http_status(:ok)
      end
    end

    it 'should render bad request if aparams are invalid' do
      expect_any_instance_of(SearchParams).to receive(:invalid?).and_call_original
      expect_any_instance_of(SearchParams).to receive(:errors).at_least(1).and_call_original

      get :index, {
        params: {
          term: 'ruby'
        }
      }

      expect(response).to have_http_status(:bad_request)
    end
  end
end

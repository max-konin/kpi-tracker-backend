require 'rails_helper'

RSpec.describe 'Api::V1::Categories', type: :request do
  describe 'GET /api/v1/categories' do
    let!(:category) { create :category }

    before { get '/api/v1/categories' }

    it { expect(response).to have_http_status(200) }
    it { expect(json['data'].size).to eq(1) }
  end

  describe 'GET /api/v1/categories/:id' do
    context 'when there is a category with passed id' do
      let(:category) { create :category }

      before { get "/api/v1/categories/#{category.id}" }
  
      it { expect(response).to have_http_status(200) }
      it 'renders the category in JSON:API format' do
        data = json['data']
        expect(data['id']).to eq category.id.to_s
        expect(data['type']).to eq 'categories'
        expect(data['attributes']['kpi-period']).to eq category.kpi_period
        expect(data['attributes']['kpi-quantity-goal']).to eq category.kpi_quantity_goal
        expect(data['attributes']['name']).to eq category.name
      end
    end

    context 'when there is not a category with passed id' do
      before { get '/api/v1/categories/999' }
  
      it { expect(response).to have_http_status(404) }
    end
  end
end

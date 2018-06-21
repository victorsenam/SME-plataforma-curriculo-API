require 'rails_helper'

RSpec.describe Api::ActivitiesController, type: :controller do

  let(:response_body) { JSON.parse(response.body) }

  before :each do
    request.env['HTTP_ACCEPT'] = 'application/json'
  end

  describe 'GET #show' do
    let(:activity_sequence) { create :activity_sequence }
    let(:activity_type) { create :activity_type }
    let(:activity) {
        create :activity,
        activity_sequence_id: activity_sequence.id,
        activity_type_ids: [activity_type.id]
    }

    context 'returns http no content' do
      it 'returns no content' do
        get :show, params: {
            activity_sequence_slug: activity_sequence.slug,
            activity_slug: 'invalid-slug'
        }

        expect(response).to be_successful
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'returns http success' do
      it 'returns http success' do
        get :show, params: {
            activity_sequence_slug: activity_sequence.slug,
            activity_slug: activity.slug
        }

        expect(response.content_type).to eq('application/json')
        expect(response).to be_successful
      end

      it 'return valid JSON all filters' do
        get :show, params: {
            activity_sequence_slug: activity_sequence.slug,
            activity_slug: activity.slug
        }

        expect(response_body['sequence']).to be_present
        expect(response_body['title']).to be_present
        expect(response_body['estimated_time']).to be_present
        expect(response_body['activity_sequence']).to be_present
        expect(response_body['image']).to be_present
        expect(response_body['activity_types']).to be_present
        expect(response_body['content']).to be_present
      end

        it 'return valid activity sequence JSON' do
        get :show, params: {
            activity_sequence_slug: activity_sequence.slug,
            activity_slug: activity.slug
        }

        expect(response_body['activity_sequence']).to be_present
        expect(response_body['activity_sequence']['title']).to be_present
      end

      it 'return valid activity types JSON' do
        get :show, params: {
            activity_sequence_slug: activity_sequence.slug,
            activity_slug: activity.slug
        }

        expect(response_body['activity_types']).to be_present
        expect(response_body['activity_types'][0]['name']).to be_present
      end
    end
  end
end
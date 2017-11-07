require 'rails_helper'

describe 'Ratings' do
  subject { create(:post) }

  context 'new' do
    before { post '/rate_post', params: { post_id: subject.id, rate: 5 } }

    it 'is return success status' do
      expect(response).to have_http_status(200)
    end

    it { expect(JSON.parse(response.body)["#{subject.id}"]).to eq '5.0' }
  end

  context 'old return' do
    before do
      subject.ratings.create(rate: 5)
      post '/rate_post', params: { post_id: subject.id, rate: 1 }
    end

    it 'success status' do
      expect(response).to have_http_status(200)
    end

    it 'average rating' do
      expect(JSON.parse(response.body)["#{subject.id}"]).to eq '3.0'
    end
  end

  context 'invalid without' do
    after do
      expect(response).to have_http_status(422)
    end

    it 'post id' do
      post '/rate_post', params: { rating: 5 }
    end

    it 'rating' do
      post '/rate_post', params: { post_id: subject.id }
    end

    it 'correct rating' do
      post '/rate_post', params: { post_id: subject.id, rating: 'f' }
    end

    it 'params' do
      post '/rate_post'
    end
  end
end

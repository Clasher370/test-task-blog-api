require 'rails_helper'

describe 'Ratings' do
  subject { create(:post) }

  context 'new' do
    before { post '/rate_post', params: { post_id: subject.id, rate: 5 } }

    it 'is return success status' do
      expect(response).to have_http_status(200)
    end

    it { expect(JSON.parse(response.body)['post_rating']).to eq 5.0 }
  end

  context 'old' do
    before do
      post.ratings.create(rate: 5)
      post '/rate_post', params: { post_id: subject.id, rating: 1 }
    end

    it 'is return success status' do
      expect(response).to have_http_status(200)
    end

    it 'is return average rating' do
      expect(JSON.parse(response.body)['post_rating']).to eq 3.0
    end
  end

  context 'invalid without' do
    it 'post id' do
      post '/rate_post', params: { rating: 5 }
      expect(response).to have_http_status(422)
    end

    it 'rating' do
      post '/rate_post', params: { post_id: subject.id }
      expect(response).to  have_http_status(422)
    end

    it 'correct rating' do
      post '/rate_post', params: { post_id: subject.id, rating: 'f' }
      expect(response).to  have_http_status(422)
    end

    it 'params' do
      post '/rate_post'
      expect(response).to have_http_status(422)
    end
  end
end

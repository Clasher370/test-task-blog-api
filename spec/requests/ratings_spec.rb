require 'rails_helper'

describe 'Ratings' do
  let!(:user) { create(:user)}
  let!(:new_post) { create(:post, user_id: user.id) }

  context 'new rating' do
    before { post '/rate_post', params: { post_id: new_post.id, rating: 5 } }

    it 'is return status 200' do
      expect(response).to have_http_status(200)
    end
    it { expect(JSON.parse(response.body)['error']).to be_nil }
    it { expect(JSON.parse(response.body)['average_rating']).to eq 5.0 }
  end

  context 'old rating' do
    let!(:old_rating) { create(:rating, post_id: new_post.id, post_rating: 5.0, rating_count: 5)}

    before { post '/rate_post', params: { post_id: new_post.id, rating: 1 } }

    it { expect(JSON.parse(response.body)['average_rating']).to eq 4.3 }
  end

  context 'invalid without' do
    it 'post id' do
      post '/rate_post', params: { rating: 5 }
      expect(response).to have_http_status(422)
    end

    it 'rating' do
      post '/rate_post', params: { post_id: new_post.id }
      expect(response).to  have_http_status(422)
    end

    it 'correct rating' do
      post '/rate_post', params: { post_id: new_post.id, rating: 'f' }
      expect(response).to  have_http_status(422)
    end

    it 'params' do
      post '/rate_post'
      expect(response).to have_http_status(422)
    end
  end
end

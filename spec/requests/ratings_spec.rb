require 'rails_helper'

describe 'Ratings' do
  let!(:user) { User.create(login: 'Vasya')}
  let!(:new_post) { Post.create(title: 'Hello', content: 'World', user_id: user.id) }

  context 'new rating' do
    before { post '/rating', params: { post_id: new_post.id, rating: 5 } }

    it 'is return status 200' do
      expect(response).to have_http_status(200)
    end
    it { expect(JSON.parse(response.body)['error']).to be_nil }
    it { expect(JSON.parse(response.body)['average_rating']).to eq 5.0 }
  end

  context 'old rating' do
    let!(:old_rating) { Rating.create(post_id: new_post.id, post_rating: 5.0, rating_count: 5)}

    before { post '/rating', params: { post_id: new_post.id, rating: 1 } }

    it { expect(JSON.parse(response.body)['average_rating']).to eq 4.3 }
  end

  context 'invalid without' do
    it 'post id' do
      post '/rating', params: { rating: 5 }
      expect(response).to have_http_status(422)
    end

    it 'rating' do
      post '/rating', params: { post_id: new_post.id }
      expect(response).to  have_http_status(422)
    end

    it 'correct rating' do
      post '/rating', params: { post_id: new_post.id, rating: 'f' }
      expect(response).to  have_http_status(422)
    end

    it 'params' do
      post '/rating'
      expect(response).to have_http_status(422)
    end
  end
end

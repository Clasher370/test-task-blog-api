require 'rails_helper'

describe 'Posts' do
  context '#top' do
    let!(:user) { User.create(login: 'Vasya') }

    let!(:post1) { Post.create(title: 'Post1', user_id: user.id)}
    let!(:post2) { Post.create(title: 'Post2', user_id: user.id)}

    let!(:rating1) { Rating.create(post_id: post1.id, post_rating: 4) }
    let!(:rating2) { Rating.create(post_id: post2.id, post_rating: 5) }


    it 'is return top rated posts' do
      post '/top_post', params: { limit: 2 }

      expect(response).to have_http_status 200
      expect(JSON.parse(response.body)[0]['title']).to eq 'Post2'
    end
  end
end

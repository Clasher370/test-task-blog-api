require 'rails_helper'

describe 'Posts' do
  let!(:user) { create(:user) }
  let!(:another_user) { create(:user) }

  let(:ip) { Faker::Internet.ip_v4_address }
  let(:another_ip) { Faker::Internet.ip_v4_address }

  let!(:post1) { create(:post, user_id: user.id, ip: ip) }
  let!(:post2) { create(:post, user_id: user.id, ip: another_ip) }
  let!(:post3) { create(:post, user_id: another_user.id, ip: another_ip) }

  let!(:rating1) { Rating.create(post_id: post1.id, post_rating: 4) }
  let!(:rating2) { Rating.create(post_id: post2.id, post_rating: 5) }

  context '#top' do
    before { post '/top_post', params: { limit: 2 } }

    it { expect(response).to have_http_status 200 }

    it 'is return top rated post' do
      expect(JSON.parse(response.body)[0]['title']).to eq post2.title
    end

    it 'is return title and content' do
      expect(JSON.parse(response.body)[0]).to eq({ "title" => post2.title, 'content' => post2.content })
    end

    it { expect(JSON.parse(response.body).count).to eq 2 }
  end

  context '#ip_with_more_when_one_users' do
    it 'is return post if more 1 user' do
      get '/ips'
      expect(JSON.parse(response.body)[0]).to eq({ 'ip' => another_ip, 'login' => [ user.login, another_user.login] })
    end
  end
end

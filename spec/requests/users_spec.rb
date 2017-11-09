require 'rails_helper'

describe 'Users' do
  describe '#by_ip' do
    let(:ip) { Faker::Internet.ip_v4_address }

    let!(:post) { create :post, ip: ip }
    let!(:another_post) { create :post, ip: ip }

    it 'return array of login by ip if more when one user' do
      get '/users/by_ip'
      expect(response).to have_http_status 200
      expect(JSON.parse(response.body)).to eq([{ "#{ip}" => [post.user.login, another_post.user.login] }])
    end
  end
end

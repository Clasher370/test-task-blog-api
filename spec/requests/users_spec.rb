require 'rails_helper'

describe 'Users' do
  describe '#by_ip' do
    let(:ip) { Faker::Internet.ip_v4_address }

    let!(:post) { create :post, ip: ip }
    let!(:another_post) { create :post, ip: ip }

    before { get '/users/by_ip' }

    it { expect(response).to have_http_status 200 }

    it 'return array of login by ip if more when one user' do
      expect(JSON.parse(response.body))
          .to eq([{ "#{ip}" => [post.user.login, another_post.user.login] }])
    end
  end
end

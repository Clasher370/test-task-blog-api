require 'rails_helper'

describe 'Posts' do
  describe 'create request' do
    context 'with valid attributes' do
      context 'exist user' do
        let(:user) { create :user }
        let(:post_attr) { attributes_for :post, login: user.login  }

        before do
          post '/create_post', params: post_attr
        end

        it 'is return success status' do
          expect(response).to have_http_status 200
        end
      end

      context 'new user' do
        let(:user) { build :user }
        let(:post_attr) { attributes_for :post, login: user.login }

        it 'create user' do
          expect { post '/create_post', params: post_attr }.to change { User.count }
        end
      end
    end

    context 'invalid without' do
      let(:user) { create :user }

      it 'title' do
        post '/create_post', params: { content: 'Text', login: 'User'}
        expect(response).to have_http_status 422
        expect(JSON.parse(response.body)['title']).to match ["can't be blank"]
      end

      it 'content' do
        post '/create_post', params: { title: 'Title', login: 'User'}
        expect(response).to have_http_status 422
        expect(JSON.parse(response.body)['content']).to match ["can't be blank"]
      end

      it 'login' do
        post '/create_post'
        expect(response).to have_http_status 422
        expect(JSON.parse(response.body)['login']).to match ["can't be blank"]
      end
    end
  end
end

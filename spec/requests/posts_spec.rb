require 'rails_helper'

describe 'Posts' do
  describe '#create' do
    let(:user) { create :user }
    let(:post_attr) { attributes_for :post }

    context 'with valid attributes when user' do
      context 'exist' do
        before do
          post '/create_post', params: post_attr.merge({ login: user.login })
        end

        it 'is return success status' do
          expect(response).to have_http_status 200
        end
      end

      context 'is new' do
        it 'create user' do
          expect { post '/create_post', params: post_attr.merge({ login: 'New_user' }) }
              .to change { User.count }
        end
      end
    end

    context 'invalid without' do
      after do
        expect(response).to have_http_status 422
      end

      it 'all attr' do
        post '/create_post'
        expect(JSON.parse(response.body)['errors'].count).to eq 3
      end

      it 'title' do
        post '/create_post', params: post_attr.except(:title)
        expect(JSON.parse(response.body)['errors']['title']).to match ["can't be blank"]
      end

      it 'content' do
        post '/create_post', params: post_attr.except(:content)
        expect(JSON.parse(response.body)['errors']['content']).to match ["can't be blank"]
      end

      it 'login' do
        post '/create_post', params: post_attr
        expect(JSON.parse(response.body)['errors']['user_id']).to match ["can't be blank"]
      end
    end
  end

  describe '#top_posts' do
    let!(:first_post) { create :post_with_rating, rating: 4 }
    let!(:second_post) { create :post_with_rating, rating: 5 }
    let!(:third_post) { create :post }

    before do
      get '/posts/top'
    end

    it 'with limit' do
      get '/posts/top', params: { limit: 2 }
      expect(JSON.parse(response.body).count).to eq 2
    end

    it 'success status' do
      expect(response).to have_http_status 200
    end

    it 'return array of posts' do
      expect(JSON.parse(response.body).count).to eq 3
    end

    it 'first is a top rated post' do
      expect(JSON.parse(response.body)[0]['title']).to eq second_post.title
    end

    it 'last is a post without rate' do
      expect(JSON.parse(response.body)[2]['title']).to eq third_post.title
    end
  end
end

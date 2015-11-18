require 'rails_helper'

RSpec.describe Api::PostsController, type: :controller do
  let(:message) { FactoryGirl.build(:post) }

  describe '#create' do
    it 'returns 200' do
      post :create, format: :json, post: message.attributes
      expect(response).to have_http_status :success
    end

    it 'returns 406' do
      message.name = nil
      post :create, format: :json, post: message.attributes
      expect(response).to have_http_status :not_acceptable
    end
  end

  describe '.persisted object' do
    before do
      message.save
    end

    describe '#update' do
      it 'returns 200' do
        message.title = 'hello world'
        patch :update, format: :json, id: message.id, post: message.attributes
        expect(response).to have_http_status :success
        expect(assigns(:post).title).to eq 'hello world'
      end

      it 'returns 406' do
        message.name = nil
        patch :update, format: :json, id: message.id, post: message.attributes
        expect(response).to have_http_status :not_acceptable
      end
    end

    describe '#destroy' do
      it 'returns 200' do
        delete :destroy, id: message.id, format: :json
        expect(response).to have_http_status :success
      end
    end

    describe '#show' do
      it 'returns 200' do
        get :show, id: message.id, format: :json
        expect(response).to have_http_status :success
      end
    end
  end
end

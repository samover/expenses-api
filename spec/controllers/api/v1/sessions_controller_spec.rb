require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:token) { Base64.encode64("#{user.email}:#{user.password}") }

  describe 'POST #create' do
    context 'when submitting correct credentials' do
      before(:each) do
        request.headers['Authorization'] = "Basic #{token}"
        post :create
      end

      it 'returns user and token corresponding to the given credentials' do
        expect(json_response[:user][:auth_token]).to eql user['auth_token']
      end

      it { is_expected.to respond_with 200 }
    end

    context 'when submitting wrong credentials' do
      before(:each) do
        basic_token = Base64.encode64('someone@example.com:password')
        request.headers['Authorization'] = "Basic #{basic_token}"
        post :create
      end

      it 'returns json errors' do
        expect(json_response[:error]).to include 'Incorrect credentials'
      end

      it { is_expected.to respond_with 401 }
    end
  end

  describe 'DELETE #destroy' do
    before do
      request.headers['Authorization'] = "Token token=#{user.auth_token}"
      delete :destroy, { id: user.id }
    end

    it 'returns a json error when performing a query' do
      delete :destroy, { id: user.id }
      expect(json_response[:error]).to eql "Bad token"
    end

    it { is_expected.to respond_with 204 }
  end
end

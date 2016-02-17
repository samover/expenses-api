require 'rails_helper'

describe ApplicationController do
  let(:user) { FactoryGirl.create(:user) }

  describe '#sign_in' do
    context 'when submitting correct credentials' do
      before(:each) do
        basic_token = Base64.encode64("#{user.email}:#{user.password}")
        request.headers['Authorization'] = "Basic #{basic_token}"
        get :sign_in
      end

      it 'returns a user auth_token' do
        expect(json_response[:token]).to eql user['auth_token']
      end

      it { is_expected.to respond_with 200 }
    end

    context 'when submitting wrong credentials' do
      before(:each) do
        basic_token = Base64.encode64('someone@example.com:password')
        request.headers['Authorization'] = "Basic #{basic_token}"
        get :sign_in
      end

      it 'returns json errors' do
        expect(json_response[:error]).to include 'Incorrect credentials'
      end

      it { is_expected.to respond_with 401 }
    end
  end

  describe '#sign_out' do
    before do
      request.headers['Authorization'] = "Token token=#{user.auth_token}"
      get :sign_out
    end

    it 'returns a json error when performing a query' do
      get :sign_out
      expect(json_response[:error]).to eql "Bad token"
    end

    it { is_expected.to respond_with 204 }
  end
end

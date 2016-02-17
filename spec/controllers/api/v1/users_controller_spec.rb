require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  describe 'GET #show' do
    before(:each) { get :show, id: user.id}

    it 'returns the information about a reporter on a hash' do
      expect(json_response[:user][:email]).to eql user.email
    end

    it { is_expected.to respond_with 200 }
  end

  describe 'POST #create' do
    let(:user_attributes) { FactoryGirl.attributes_for :user }
    let(:invalid_attributes) { FactoryGirl.attributes_for(:user, email: '') }

    context 'when is successfully created' do
      before(:each) { post :create, { user: user_attributes } }
      
      it 'renders the json representation for the user just created' do
        expect(json_response[:user][:email]).to eql user_attributes[:email]
      end

      it { is_expected.to respond_with 201 }
    end

    context 'when is not created' do
      before(:each) { post :create, { user: invalid_attributes } }

      it 'renders the json errors on why the user entry cannot be created' do
        expect(json_response[:errors][:email]).to include "can't be blank"
      end

      it { is_expected.to respond_with 422 }
    end
  end

  describe 'PATCH #update' do
    context 'when is succesfully updated' do
      before(:each) do
        patch :update, { id: user.id, user: { email: 'newemail@example.com' } }
      end

      it 'renders the json representation of the user just updated' do
        expect(json_response[:user][:email]).to eql 'newemail@example.com'
      end

      it { is_expected.to respond_with 200 }
    end

    context 'when is not successful' do
      before(:each) do
        patch :update, { id: user.id, user: { email: '' } }
      end

      it 'renders the json errors on why the user entry cannot be created' do
        expect(json_response[:errors][:email]).to include "can't be blank"
      end

      it { is_expected.to respond_with 422 }
    end
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, { id: user.id } }

    it { is_expected.to respond_with 204 }
  end
end

require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do
  let(:category) { FactoryGirl.create(:category) }

  describe 'GET #index' do
    before(:each) do
      FactoryGirl.create_list(:category, 20)
      get :index
    end

    it 'returns all the categories in the database' do 
      expect(json_response.length).to eql 20
    end

    it { is_expected.to respond_with 200 }
  end

  describe 'GET #show' do
    before(:each) { get :show, id: category.id}

    it 'returns the information about a reporter on a hash' do
      expect(json_response[:name]).to eql category.name
    end

    it { is_expected.to respond_with 200 }
  end

  describe 'POST #create' do
    let(:category_attributes) { FactoryGirl.attributes_for :category }
    let(:invalid_attributes) { FactoryGirl.attributes_for(:category, name: '') }

    context 'when is successfully created' do
      before(:each) { post :create, { category: category_attributes } }
      
      it 'renders the json representation for the category just created' do
        expect(json_response[:name]).to eql category_attributes[:name]
      end

      it { is_expected.to respond_with 201 }
    end

    context 'when is not created' do
      before(:each) { post :create, { category: invalid_attributes } }

      it 'renders the json errors on why the category entry cannot be created' do
        expect(json_response[:errors][:name]).to include "can't be blank"
      end

      it { is_expected.to respond_with 422 }
    end
  end

  describe 'PATCH #update' do
    context 'when is succesfully updated' do
      before(:each) do
        patch :update, { id: category.id, category: { name: 'An updated name' } }
      end

      it 'renders the json representation of the category just updated' do
        expect(json_response[:name]).to eql 'An updated name'
      end

      it { is_expected.to respond_with 200 }
    end

    context 'when is not successful' do
      before(:each) do
        patch :update, { id: category.id, category: { name: '' } }
      end

      it 'renders the json errors on why the category entry cannot be created' do
        expect(json_response[:errors][:name]).to include "can't be blank"
      end

      it { is_expected.to respond_with 422 }
    end
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, { id: category.id } }

    it { is_expected.to respond_with 204 }
  end
end

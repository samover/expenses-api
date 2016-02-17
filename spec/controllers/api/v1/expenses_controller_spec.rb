require 'rails_helper'

RSpec.describe Api::V1::ExpensesController, type: :controller do
  let(:expense) { FactoryGirl.create(:expense) }

  describe 'GET #show' do
    before(:each) { get :show, id: expense.id}

    it 'returns the information about a reporter on a hash' do
      expect(json_response[:expense][:title]).to eql expense.title
    end

    it { is_expected.to respond_with 200 }
  end

  describe 'POST #create' do
    let(:expense_attributes) { FactoryGirl.attributes_for :expense }
    let(:invalid_attributes) { FactoryGirl.attributes_for(:expense, title: '') }

    context 'when is successfully created' do
      before(:each) { post :create, { expense: expense_attributes } }
      
      it 'renders the json representation for the expense just created' do
        expect(json_response[:expense][:title]).to eql expense_attributes[:title]
      end

      it { is_expected.to respond_with 201 }
    end

    context 'when is not created' do
      before(:each) { post :create, { expense: invalid_attributes } }

      it 'renders the json errors on why the expense entry cannot be created' do
        expect(json_response[:errors][:title]).to include "can't be blank"
      end

      it { is_expected.to respond_with 422 }
    end
  end

  describe 'PATCH #update' do
    context 'when is succesfully updated' do
      before(:each) do
        patch :update, { id: expense.id, expense: { title: 'An updated title' } }
      end

      it 'renders the json representation of the expense just updated' do
        expect(json_response[:expense][:title]).to eql 'An updated title'
      end

      it { is_expected.to respond_with 200 }
    end

    context 'when is not successful' do
      before(:each) do
        patch :update, { id: expense.id, expense: { amount: '' } }
      end

      it 'renders the json errors on why the expense entry cannot be created' do
        expect(json_response[:errors][:amount]).to include "can't be blank"
      end

      it { is_expected.to respond_with 422 }
    end
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, { id: expense.id } }

    it { is_expected.to respond_with 204 }
  end
end

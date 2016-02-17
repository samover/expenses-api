require 'rails_helper'

RSpec.describe Api::V1::ExpensesController, type: :controller do
  let(:expense) { FactoryGirl.create(:expense, 
                              user: FactoryGirl.create(:user),
                              category: FactoryGirl.create(:category)) }

  before(:each) do
    request.headers['Accept'] = 'application/vnd.accounts.v1'
  end

  describe 'GET #show' do
    before(:each) { get :show, id: expense.id, format: :json }

    it 'returns the information about a reporter on a hash' do
      expense_response = JSON.parse(response.body, symbolize_names: true)
      expect(expense_response[:title]).to eql expense.title
    end

    it { is_expected.to respond_with 200 }
  end

  describe 'POST #create' do
    let(:expense_attributes) { FactoryGirl.attributes_for :expense }
    let(:invalid_attributes) { FactoryGirl.attributes_for(:expense, title: '') }

    context 'when is successfully created' do
      before(:each) do 
        post :create, { expense: expense_attributes }, format: :json
      end
      
      it 'renders the json representation for the expense just created' do
        expense_response = JSON.parse(response.body, symbolize_names: true)
        expect(expense_response[:title]).to eql expense_attributes[:title]
      end

      it { is_expected.to respond_with 201 }
    end

    context 'when is not created' do
      before(:each) do
        post :create, { expense: invalid_attributes }, format: :json
      end

      it 'renders the json errors' do
        expense_response = JSON.parse(response.body, symbolize_names: true)
        expect(expense_response).to have_key(:errors)
      end

      it 'renders the json errors on why the expense entry cannot be created' do
        expense_response = JSON.parse(response.body, symbolize_names: true)
        expect(expense_response[:errors][:title]).to include "can't be blank"
      end

      it { is_expected.to respond_with 422 }
    end
  end
end

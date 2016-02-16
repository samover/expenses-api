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
end

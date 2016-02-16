class Api::V1::ExpensesController < ApplicationController

  def show
    expense = Expense.find_by(params[:id])
    render json: expense
  end
end

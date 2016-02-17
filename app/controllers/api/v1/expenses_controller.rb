class Api::V1::ExpensesController < ApplicationController

  def index
    expenses = Expense.all
    render json: expenses
  end

  def show
    expense = Expense.find_by(params[:id])
    render json: expense
  end

  def create
    expense = Expense.new(expense_params)

    if expense.save
      render json: expense, status: 201, location: [:api, expense]
    else
      render json: { errors: expense.errors }, status: 422
    end
  end

  def update
    expense = Expense.find(params[:id])

    if expense.update(expense_params)
      render json: expense, status: 200, location: [:api, expense]
    else
      render json: { errors: expense.errors }, status: 422
    end
  end

  def destroy
    expense = Expense.find(params[:id])
    expense.destroy
    head 204
  end

  private

  def expense_params
    params.require(:expense).permit(:date, :title, :amount, :user_id, :category_id)
  end
end

require 'rails_helper'

RSpec.describe Expense, type: :model do
  it { is_expected.to belong_to :category }
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of :date }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :amount }
end

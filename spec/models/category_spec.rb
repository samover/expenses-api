require 'rails_helper'

RSpec.describe Category, type: :model do
  subject(:category) { FactoryGirl.build :category }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to have_many :expenses } 
  it { is_expected.to be_valid }
end

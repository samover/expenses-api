require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of :email }
  it { is_expected.to allow_value('user@example.com').for(:email) }
  it { is_expected.not_to allow_value('userexample.com').for(:email) } 
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to validate_confirmation_of :password }

  it { is_expected.to have_many :expenses }
end

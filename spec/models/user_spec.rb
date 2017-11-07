require 'rails_helper'

describe User do
  it { is_expected.to respond_to :login }
  it { should have_many :posts }

  it { should validate_presence_of :login }
end

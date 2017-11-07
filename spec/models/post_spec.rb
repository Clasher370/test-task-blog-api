require 'rails_helper'

describe Post do
  %i[title content ip].each do |s|
    it { is_expected.to respond_to s }
  end

  %i[title content user_id].each do |attr|
    it { should validate_presence_of(attr) }
  end

  it { should belong_to :user }
  it { should have_many :ratings }
end

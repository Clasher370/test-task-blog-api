require 'rails_helper'

describe Rating do
  it { is_expected.to respond_to :rate }

  it { should belong_to :post }
end

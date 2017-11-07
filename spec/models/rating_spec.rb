require 'rails_helper'

describe Rating do
  it { should respond_to :rate }
  it { should belong_to :post }
end

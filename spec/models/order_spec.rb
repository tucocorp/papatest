require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should have_and_belong_to_many(:products) }
  it { should belong_to(:store) }
end

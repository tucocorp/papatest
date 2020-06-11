# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Store, type: :model do

  it { should validate_length_of(:name).is_at_most(250).on(:create) }
  it { should validate_length_of(:address).is_at_most(1000).on(:create) }
  it { should validate_length_of(:phone).is_at_most(250).on(:create) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:phone) }

  it "if email is blank, seting up a default email" do
  	expect(Store.create.email).to eq('francisco.abalan@pjchile.com')
  end
end

require 'rails_helper'

RSpec.describe Message, type: :model do
  
  it "creates a Message when given an email" do
    email = create(:email)
    Message.create_from_email(email)
    expect(Message.count).to eq(1)  
  end
end

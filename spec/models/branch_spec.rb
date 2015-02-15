require 'rails_helper'

RSpec.describe Branch, type: :model do
  
  describe "validations" do
  end
  
  describe "associations" do
    it { should belong_to :user }
    it { should have_many :messages}
  end
  
  describe "methods" do
    it "creates a Branch when given an email subject" do
      Branch.get_from_subject("Test Subject")
      expect(Branch.count).to eq(1)
    end
  
    it "sets the lower_subjects array based on the subject submitted" do
      Branch.get_from_subject("Test Subject")
      expect(Branch.last.lower_subjects).to eq(["test subject"])
    end
  
    it "does not create a new Branch if one already exists with the subject" do
      create(:branch, subject: "Test Subject")
      expect(Branch.count).to eq(1)
      Branch.get_from_subject("Test Subject")
      expect(Branch.count).to eq(1)
    end
  end
end

require 'rails_helper'

RSpec.describe Branch, type: :model do
  
  describe "validations" do
    it { should validate_presence_of :subject }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :account_id }
  end
  
  describe "associations" do
    it { should belong_to :user }
    it { should have_many :messages}
    it { should have_many :caches}
  end
  
  describe "respond_to" do
    #it { should respond_to(:some_instance_method).with(2).arguments }
  end
  
  describe "methods" do
    before :each do
      @user_id = SecureRandom.uuid
      @account_id = SecureRandom.uuid
    end
    
    it "creates a Branch when given an email subject" do
      Branch.get_from_subject("Test Subject", @user_id, @account_id)
      expect(Branch.count).to eq(1)
    end
  
    it "sets the lower_subjects array based on the subject submitted" do
      Branch.get_from_subject("Test Subject", @user_id, @account_id)
      expect(Branch.last.lower_subjects).to eq(["test subject"])
    end
  
    it "does not create a new Branch if one already exists with the subject" do
      create(:branch)
      expect(Branch.count).to eq(1)
      Branch.get_from_subject("This is an example webhook message", @user_id, @account_id)
      expect(Branch.count).to eq(1)
    end
  end
end

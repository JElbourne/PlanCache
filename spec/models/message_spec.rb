require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "validations" do
  end
  
  describe "associations" do
    it { should belong_to :user }
    it { should belong_to :branch}
  end
  
  describe "respond_to" do
    #it { should respond_to(:some_instance_method).with(2).arguments }
  end
  
  describe "methods" do
    it "creates a Message when given an email" do
      email = create(:email)
      branch = create(:branch, subject: email.subject)
      Message.create_from_email(email, branch.id)
      expect(Message.count).to eq(1)
      expect(Message.last.email).to eq("from_email@email.com")
      expect(Message.last.files_json).to be_nil
    end
  
    it "creates a Message with files_json when given an email with attachments" do
      email = create(:email, :with_attachment)
      branch = create(:branch, subject: email.subject)
      Message.create_from_email(email, branch.id)
      expect(Message.count).to eq(1)
      expect(Message.last.files_json).to eq({"e8ef1112eb2f0edfc54383dd78fc5f9803fc776d"=>{"file_name"=>"img.png", "file_size"=>78936, "content_type"=>"image/png", "key"=>"e8ef1112eb2f0edfc54383dd78fc5f9803fc776d", "public_url"=>nil}}) 
    end
  end
end

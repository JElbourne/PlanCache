require 'rails_helper'

RSpec.describe Cache, type: :model do
  describe "validations" do
    it { should validate_presence_of :branch_id }
    it { should validate_presence_of :message_id }
    it { should validate_presence_of :files_json }
  end
  
  describe "associations" do
    it { should belong_to :branch }
    it { should belong_to :message}
  end
  
  describe "respond_to" do
    #it { should respond_to(:some_instance_method).with(2).arguments }
  end
  
  describe "methods" do
    
  end
end

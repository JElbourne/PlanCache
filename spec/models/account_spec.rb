require 'rails_helper'

RSpec.describe Account, type: :model do
  
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :key }
  end
  
  describe "associations" do
    it { should belong_to :user }
    it { should have_many :branches}
  end
  
  describe "respond_to" do
    #it { should respond_to(:some_instance_method).with(2).arguments }
  end
  
  describe "methods" do

  end
  
end

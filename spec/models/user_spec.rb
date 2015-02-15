describe User do
  
  describe "validations" do
  end
  
  describe "associations" do
    it { should have_many :messages }
    it { should have_many :branches}
  end
  
  describe "methods" do
  end
  
  describe "respond_to" do

    before(:each) { @user = FactoryGirl.create(:user, name: "Joe Bloggs") }

    subject { @user }

    it { should respond_to(:name) }
    it { should respond_to(:email) }

    it "#name returns a string" do
      expect(@user.name).to match 'Joe Bloggs'
    end
  end

end
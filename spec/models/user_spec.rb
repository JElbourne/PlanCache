describe User do

  before(:each) { @user = FactoryGirl.create(:user, name: "Joe Bloggs") }

  subject { @user }

  it { should respond_to(:name) }

  it "#name returns a string" do
    expect(@user.name).to match 'Joe Bloggs'
  end

end
feature 'User sends email to PlanCache' do
  before(:each) do
    @valid_token_base64 = SecureRandom.urlsafe_base64(6, false)
    @valid_to = [{ full: "Joe Bloggs <#{@valid_token_base64}.to_user@email.com>", email: "#{@valid_token_base64}.to_user@email.com", token: "#{@valid_token_base64}.to_user", host: 'email.com', name: "Joe Bloggs" }]
    @invalid_to = [{ full: "Joe Bloggs <111.to_user@email.com>", email: "111.to_user@email.com", token: "111.to_user", host: 'email.com', name: "Joe Bloggs" }]
    
    @valid_emailmessage = build(:email, to: @valid_to)
    @invalid_emailmessage = build(:email, to: @invalid_to)
    
    @user = create(:user)
  end
  
  scenario 'it accepts a valid to:field[:token]' do
    page.driver.post email_processor_path, @valid_emailmessage.marshal_dump
    expect(Message.count).to eq(1)
  end
  
  scenario 'it rejects an invalid to:field[:token]' do
    page.driver.post email_processor_path, @invalid_emailmessage.marshal_dump
    expect(Message.count).to eq(0)
  end
  
  scenario 'it creates a branch for the email subject' do
    message = @valid_emailmessage
    page.driver.post email_processor_path, message.marshal_dump
    
    expect(Branch.count).to eq(1)
    
    branch = Branch.last
    expect(branch.subject).to eq(message.subject)
  end

  scenario 'it creates a message for the email body' do
    message = @valid_emailmessage
    page.driver.post email_processor_path, message.marshal_dump
    
    expect(Message.count).to eq(1)
    
    message = Message.last
    expect(message.body).to eq(message.body)
  end

end
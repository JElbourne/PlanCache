class Message < ActiveRecord::Base
  
  belongs_to :branch
  belongs_to :user
  
  def self.create_from_email(email, branch_id)
    ## TODO the files_json should all be done in a worker....(create_files_json & upload_file_to_s3) pass it the attachemnts data
    files_json = email.attachments.any? ? create_files_json(email.attachments) : nil
    create do |m|
      m.branch_id = branch_id
      m.email = email.from[:email]
      m.subject = email.subject if email.subject
      m.to = email.to if email.to
      m.from = email.from if email.from
      m.cc = email.cc if email.cc

      m.body = email.body if email.body
      m.raw_text = email.raw_text if email.raw_text
      m.raw_html = email.raw_html if email.raw_html
      m.raw_body = email.raw_body if email.raw_body
      m.raw_headers = email.raw_headers if email.raw_headers
      m.headers = email.headers if email.headers
      
      m.files_json = files_json
    end
  end
  
private
  
  def self.create_files_json(attachments)
    file_hash = {}
    attachments.each do |filedata|
      public_url, key = self.upload_file_to_s3(filedata)
      file_hash[key.to_s] = {:file_name => filedata.original_filename, :file_size => filedata.size, :content_type => filedata.content_type, :key => key, :public_url => public_url}
    end
    return file_hash.to_json
  end

  def self.upload_file_to_s3(filedata)
    fileString = filedata.tempfile.read
    encryptedFileString = self.encrypt_file_data(fileString)
    key = self.make_file_key(fileString)
    s3_file_url = nil
    unless Rails.env.test?
      s3_file = S3_BUCKET.objects[key].write(:file => encryptedFileString)
      s3_file.acl = :public_read
      s3_file_url = s3_file.public_url.to_s
    end
    return [s3_file_url, key]
  end
  
  def self.make_file_key(fileString)
    Digest::SHA1.hexdigest(fileString)
  end
  
  def self.encrypt_file_data(fileString)
    #TODO move the ActiveSupport::KeyGenerator.new(ENV["ENCRYPTOR_PASSCODE"]).generate_key(ENV["ENCRYPTOR_SALT"]) into the tenant so each one is specific to tenant
    encryptor = ActiveSupport::MessageEncryptor.new(ENV["ENCRYPTOR_KEY"])
    encryptor.encrypt_and_sign(fileString)
  end
  
  def self.decrypt_file_data(encryptedFile)
    #TODO move the ActiveSupport::KeyGenerator.new(ENV["ENCRYPTOR_PASSCODE"]).generate_key(ENV["ENCRYPTOR_SALT"]) into the tenant so each one is specific to tenant
    encryptor = ActiveSupport::MessageEncryptor.new(ENV["ENCRYPTOR_KEY"])
    encryptor.decrypt_and_verify(encryptedFile)
  end
end

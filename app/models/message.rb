class Message < ActiveRecord::Base
  
  def self.create_from_email(email)
    files_json = email.attachments ? create_files_json(email.attachments) : nil
    create do |m|
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
  
  def create_files_json(attachments)
    attachments.each do |filedata|
      logger.info "FILEDATA  =>  #{filedata}"
      ##public_url, key = upload_file_to_s3(fileData)
    end
    #TODO build the json and return
  end

  def upload_file_to_s3(fileData)
    key = make_file_key(filedata)
    s3_file = S3_BUCKET.objects[key].write(:file => fileData.tempfile.read)
    s3_file.acl = :public_read
    return (s3_file.public_url.to_s, key)
  end
  
  def make_file_key(file)
    Digest::SHA1.hexdigest(file.size+"/"+file.lastModifiedDate+"/"+file.name)
  end
end

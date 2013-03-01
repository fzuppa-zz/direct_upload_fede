class User < ActiveRecord::Base
  attr_accessible :name, :photo_file

  def photo_file
    file= read_attribute(:photo_file)
    return nil if file.nil?

    #object_key = file.split(/\//).last
    #AWS::S3::S3Object.url_for(
    #    CGI::unescape(object_key),
    #    'funinbairesdevelopment',
    #    use_ssl: true)
    s3 = AWS::S3.new(
        :access_key_id => 'AKIAJAGSO3IDCDEJROAA',
        :secret_access_key => 'GDVUTYYEgBhfES4ysMcFNmSuP0YdGFIxWtoBAP'
    )
    object = s3.buckets['funinbaires'].objects['path/to/object']
    object.url_for(:get, { :expires => 20.minutes.from_now, :secure => true }).to_s

  end

end

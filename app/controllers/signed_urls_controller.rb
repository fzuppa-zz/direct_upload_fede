class SignedUrlsController < ApplicationController

  def index
    render json: {
        policy: s3_upload_policy_document,
        signature: s3_upload_signature,
        key: "uploads/#{SecureRandom.uuid}/#{params[:doc][:title]}",
        success_action_redirect: "/"
    }
  end

  private

  # generate the policy document that amazon is expecting.
  def s3_upload_policy_document
    Base64.encode64(
        {
            expiration: 30.minutes.from_now.utc.strftime('%Y-%m-%dT%H:%M:%S.000Z'),
            conditions: [
                {bucket: AMAZON_S3_CREDENTIALS['bucket']},
                {acl: 'private'},
                ["starts-with", "$key", "uploads/"],
                {success_action_status: '201'}
            ]
        }.to_json
    ).gsub(/\n|\r/, '')
  end

  # sign our request by Base64 encoding the policy document.
  def s3_upload_signature
    Base64.encode64(
        OpenSSL::HMAC.digest(
            OpenSSL::Digest::Digest.new('sha1'),
            AMAZON_S3_CREDENTIALS['secret_access_key'],
            s3_upload_policy_document
        )
    ).gsub(/\n/, '')
  end
end

class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :verify_request, only: [:login]
  # skip_after_action :verify_authorized
  # skip_after_action :verify_policy_scoped

  def login
    owner = find_user
    # puts "---------------------------"
    # puts owner
    # puts owner.id
    # puts "---------------------------"

    token = jwt_encode(owner_id: owner.id)


    render json: {
      headers: { "X-USER-TOKEN" => token },
      owner: owner
    }
  end

  private

  # retrieve/fetch open id
  def fetch_wx_open_id(code)
    puts "code in fetch wx open id #{code}"
    app_id = Rails.application.credentials.dig(:wechat, :app_id)
    app_secret = Rails.application.credentials.dig(:wechat, :app_secret)
    url = "https://api.weixin.qq.com/sns/jscode2session?appid=#{app_id}&secret=#{app_secret}&js_code=#{code}&grant_type=authorization_code"
    response = RestClient.get(url)
    puts "response #{response}"
    JSON.parse(response.body)
  end

  # find or create user
  def find_user
    open_id = fetch_wx_open_id(params[:code])['openid']
    puts "open_id #{open_id}"
    owner = Owner.find_or_create_by(open_id: open_id)
    p "----------------------"
    p "current owner: "
    p owner
    p "----------------------"
    return owner
  end

  # generate JWT
  def jwt_encode(payload)
    # puts "---------------------------"
    # puts payload
    # puts "---------------------------"

    JWT.encode payload, HMAC_SECRET, 'HS256'
  end
end

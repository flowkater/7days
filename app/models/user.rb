class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  # user and weekplans model
  has_many :weekplans, dependent: :destroy

  #Login
  def self.from_omniauth(auth)
      where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
        user.name = auth.info.name
        user.email = auth.info.email
        user.provider = auth.provider
        user.uid = auth.uid
        user.token = auth.credentials.token
        user.auth_expires_at = Time.at(auth.credentials.expires_at)
        user.save!
      end
  end

  def self.new_with_session(params, session)
      if session["devise.user_attributes"]
        new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  #devise제공 password. provider존재할 경우 password없어도 됨.
  def password_required?
      super && provider.blank?
  end

  #edit profile할 때 current_password 있는지 체크하는 부분.
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
        super
    end
  end

 ##Facebook Graph API
  
  #FB Graph API연결할 메서드
  # 세션 문제... 여기에 새 토큰 가져오는 코드 추가하기!!! or 에러나면 로그아웃 시키기
  def facebook
    @facebook ||= Koala::Facebook::API.new(token) 
  end  

  # 로그인한 사용자 친구들 uid만 배열로 담기
  # rescue부분은 유효하지 않은 토큰문제때문에 에러발생시 결과값 대신 nil반환하여 에러가 발생하지 않도록 임시 조취..
  def friends_uids
    facebook.get_connections("me", "friends").collect {|f| f["id"]} 
  rescue Koala::Facebook::AuthenticationError 
    nil 
  end

  # 가입한 친구 찾기. IN연산자 이용 query문 남발 문제 해결
  def joined_friends
    User.where('uid IN (?)', friends_uids)
  end


  # 유저의 이번주 weekplan 가져오기
  def this_week
    time = Time.now
    thisWeekSunday = (Time.gm(time.year, time.month, time.day) - Time.now.wday * 86400)
    thisWeekSaturday = thisWeekSunday + 6.days + 86399

    weekplans.find(:first, conditions: ["created_at >= ? AND created_at <= ?", thisWeekSunday, thisWeekSaturday])
  end
end

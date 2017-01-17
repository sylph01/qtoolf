class User < ApplicationRecord
  has_many :events, foreign_key: "owner_id"

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider    = auth['provider']
      user.uid         = auth['uid']
      user.screen_name = auth['info']['nickname']
      user.name        = auth['info']['name']
    end
  end
end

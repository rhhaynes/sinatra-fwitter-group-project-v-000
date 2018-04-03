class User < ActiveRecord::Base
  validates_presence_of :username, :email, :password
  has_secure_password
  has_many :tweets
  
  def self.find_by_slug(slug)
    self.all.find{|o| o.slug == slug}
  end
  
  def slug
    self.username.downcase.gsub(/ {1,}/,"-")
  end
end
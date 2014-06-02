# -*- encoding : utf-8 -*-
require 'digest/sha1'

class User < ActiveRecord::Base
  attr_accessor :pass
  
  # validacie formulara pred vlozenim do databazy
  EMAIL_RGXP = /\A(\S+)@(.+)\.(\S+)\z/
  validates :login, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_RGXP
  validates :pass, :confirmation => true #password_confirmation attr
  validates_length_of :pass, :in => 6..20, :on => :create
  
  # spustace pred a po ulozeni a zmene modelu
  before_save :encrypt_password
  after_save :clear_password
  before_update :encrypt_password
  after_update :clear_password


  # enkryptovacia metoda
  def encrypt_password
    if pass.present?
      self.encpass = Digest::SHA1.hexdigest(pass)
    end
  end
  
  # cistiaca metoda
  def clear_password
    self.pass = nil
  end
  
  # autentifikacia prihlasenia
  def self.auth(user_or_email="", prov_pass="")
    if EMAIL_RGXP.match(user_or_email)
      user = User.find_by_email(user_or_email)
    else
      user = User.find_by_login(user_or_email)
    end
    if user && user.check_pass(prov_pass)
      return user
    else
      return false
    end
  end
  # pomocny check hesla
  def check_pass(prov_pass="")
    encpass == Digest::SHA1.hexdigest(prov_pass)
  end
end


class User < ApplicationRecord
  has_many :pins, dependent: :destroy
  has_many :donations
  mount_uploader :profpic, ProfpicUploader

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :username, :on => :create
  validates_uniqueness_of :username, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  # def self.sign_in_from_omniauth(auth)
  #   find_by(provider: auth['provider'], uid: auth[:id]) || create_user_from_omniauth(auth)
  # end
  #
  # def self.create_user_from_omniauth(auth)
  #   create (
  #           provider: auth['provider'],
  #           uid: auth['uid'],
  #           name: auth['info']['name']
  #   )
  # end

end

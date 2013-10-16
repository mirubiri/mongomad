class User
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many                :items
  has_many                :requests
  has_many                :sent_offers,     class_name: 'Offer', inverse_of: :user_composer
  has_many                :received_offers, class_name: 'Offer', inverse_of: :user_receiver
  has_and_belongs_to_many :negotiations,    inverse_of: :negotiators
  has_and_belongs_to_many :deals,           inverse_of: :signers

  embeds_one  :profile

  field :nick

  validates_presence_of :profile, :nick

  # -------------- DEVISE GENERATED----------------------------
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
    :registerable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ''
  field :encrypted_password, :type => String, :default => ''

  validates_presence_of :email
  validates_presence_of :encrypted_password

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  def sheet
    UserSheet.new(first_name:profile.first_name, last_name:profile.last_name, nick:nick, location:profile.location, images:profile.images) do |sheet|
      sheet.id=id
    end
  end
end
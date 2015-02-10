class User
  include Mongoid::Document
  include Mongoid::Timestamps

  acts_as_api
  include UserTemplates
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  # Custom Fields
  field :admin, type: Boolean, default: false
  field :password_changed, type: Boolean, default: false

  # Class methods
  def self.create_by_admin(params)
    self.new(params.merge(password: Devise.friendly_token))
  end

  # Instance methods
  def is_admin?
    self.admin
  end

  def update_password(params)
    if password_changed
      update_with_password(params)
    else
      if update_attributes(params)
        set(password_changed: true)
        true
      else
        false
      end
    end
  end
end

class User < ActiveRecord::Base
  has_many :reports
  authenticates_with_sorcery!
  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  
  validates :username, length: {in: 4..46, message: "Username must be between 5 and 45 characters in length."}
  validates :password, length: { minimum: 3, message: "Password must be greater than 3 characters" }, if: -> { new_record? || changes["password"] }
  validates :password, confirmation: true, if: -> { new_record? || changes["password"] }
  validates :password_confirmation, presence: {in: [true], message: "Please confirm your password."}, if: -> { new_record? || changes["password"] }
  validates :email, uniqueness: true
  # validates :email, :format => EMAIL_REGEX
  validates :email, format: {with: EMAIL_REGEX, message: "Email must be in sample@example.com format."}
end

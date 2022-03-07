class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  has_many :events, foreign_key: :creator_id
  has_many :event_attendances, foreign_key: :attendee_id
  has_many :attended_events, source: :event,
           class_name: "Event", through: :event_attendances
  has_many :invitations, foreign_key: :invitee_id
end

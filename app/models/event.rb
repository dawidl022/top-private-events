class Event < ApplicationRecord
  validates_presence_of :name, :start_time, :end_time ,:location

  belongs_to :creator, class_name: "User"
  has_many :event_attendances
  has_many :attendees, through: :event_attendances, class_name: "User"

  scope :upcoming, -> do
    where('start_time > ?', Time.now)
  end

  scope :ongoing, -> do
    where('start_time < ?', Time.now).where('end_time > ?', Time.now)
  end

  scope :past, -> do
    where('end_time < ?', Time.now)
  end
end

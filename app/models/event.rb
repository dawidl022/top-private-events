class DateValidator < ActiveModel::Validator
  def validate(event)
    unless event.end_time.blank? || event.end_time >= event.start_time
      event.errors.add :end_time, "cannot be before start time"
    end
  end
end

class Event < ApplicationRecord
  validates_presence_of :name, :start_time, :end_time ,:location
  validates_with DateValidator

  belongs_to :creator, class_name: "User"
  has_many :event_attendances, dependent: :delete_all
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

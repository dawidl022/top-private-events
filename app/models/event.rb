class Event < ApplicationRecord
  validates_presence_of :name, :start_time, :location

  belongs_to :creator, class_name: "User"
end

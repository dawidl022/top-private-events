class RenameEventAttendeesToEventAttendances < ActiveRecord::Migration[6.1]
  def change
    rename_table :event_attendees, :event_attendances
  end
end

class Task < ActiveRecord::Base
  belongs_to :doer, :class_name => "User"
  belongs_to :asker, :class_name => "User"

  scope :incoming, -> { where(status: "incoming")}
  scope :accepted, -> { where(status: "accepted")}
  scope :completed, -> { where(status: "completed")}
  scope :rejected, -> { where(status: "rejected")}
end

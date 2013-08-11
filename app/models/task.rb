class Task < ActiveRecord::Base
  belongs_to :doer, :class_name => "User"
  belongs_to :asker, :class_name => "User"
end

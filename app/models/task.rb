class Task < ActiveRecord::Base
  belong_to :doer, :class_name => "User"
  belong_to :asker, :class_name => "User"
end

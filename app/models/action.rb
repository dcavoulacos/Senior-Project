class Action < ActiveRecord::Base
	belongs_to :action_frame
	belongs_to :player
end

class Player < ActiveRecord::Base
	belongs_to :action_frame
	has_one :action
end

class Action < ActiveRecord::Base
	belongs_to :action_frame
	belongs_to :player

	validates :action_frame_id, :player_id, presence: true

	# validates :end_position_x, numericality: {greater_than: 0, less_than: 50}
	# validates :end_position_y, numericality: {greater_than: 0, less_than: 47}

end

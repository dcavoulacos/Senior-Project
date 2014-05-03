class Action < ActiveRecord::Base
	belongs_to :action_frame
	belongs_to :player

	def is_blank
    if self.action_type == "Move"
      return false
    elsif self.action_type == "Pass"
      return false
    elsif self.action_type == "Screen"
      return false
    elsif self.action_type == "Shoot"
      return false
    else
      return true        
	  end
	end

  def is_stand
    p = self.player
    if self.action_type == "Move"
      if p.position_x == self.end_position_x && p.position_y == self.end_position_y
        return true
      else
        return false
      end
    end
  end

	validates :action_frame_id, :player_id, presence: true

	# validates :end_position_x, numericality: {greater_than: 0, less_than: 50}
	# validates :end_position_y, numericality: {greater_than: 0, less_than: 47}

end

class Player < ActiveRecord::Base
	belongs_to :set_play
	has_many :actions, dependent: :destroy

	def current_action(currentAF)
		currentAF.actions.find_by_player_id(self.id)
	end
end

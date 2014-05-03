class SetPlay < ActiveRecord::Base
		has_many :action_frames, dependent: :destroy
		has_many :players, dependent: :destroy, :limit => 5
		belongs_to :offense
	
		def pg
			self.players.find_by_role("PG")
		end

		def sg
			self.players.find_by_role("SG")
		end

		def sf
			self.players.find_by_role("SF")
		end

		def pf
			self.players.find_by_role("PF")
		end

		def c
			self.players.find_by_role("C")
		end	
end

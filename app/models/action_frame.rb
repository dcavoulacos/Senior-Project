class ActionFrame < ActiveRecord::Base
	# To figure out, how to get AFs to reference self
	# has_one :next, class_name: "ActionFrame", foreign_key: 
	# belongs_to :prev, class_name: "ActionFrame"

	has_many :actions, dependent: :destroy, :limit => 5
	belongs_to :set_play

	belongs_to :prev, class_name: 'ActionFrame'
	has_one :next, class_name: 'ActionFrame',
								 foreign_key: 'next_id', dependent: :destroy

	def has_blank
		self.actions.each do |a|
			if a.is_blank
				return true
			end
		end
		return false
	end

	def pg
		self.actions.find_by_player_id(self.set_play.pg.id)
	end

	def sg

	end

	def sf

	end

	def pf

	end

	def c

	end
end
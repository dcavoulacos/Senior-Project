class ActionFrame < ActiveRecord::Base
	# To figure out, how to get AFs to reference self
	# has_one :next, class_name: "ActionFrame", foreign_key: 
	# belongs_to :prev, class_name: "ActionFrame"

	has_many :players, dependent: :destroy, :limit => 5

	# This my change, but for now leave it same as players.
	has_many :actions, dependent: :destroy, :limit => 5
end
class Interest < ActiveRecord::Base
	searchkick

	include Tire::Model::Search
	include Tire::Model::Callbacks

	def self.search(search)
		if search
			where('name LIKE ?', "%#{search}%")
		else
			scoped
		end
	end
end

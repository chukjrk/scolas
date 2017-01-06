class Subject < ActiveRecord::Base
	has_many :posts
	has_many :users, through: :posts
	validates_presence_of :name
	validates_uniqueness_of :name

  	def self.search(search)
		if search
			where('name LIKE ?', "%#{search}%")
		else
			scoped
		end
	end
	# searchkick

end

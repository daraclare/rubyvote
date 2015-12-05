class Poll < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :title

	has_many :questions
	has_many :replies

end

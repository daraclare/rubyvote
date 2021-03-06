class Question < ActiveRecord::Base

	belongs_to :poll
 	has_many :possible_answers
 	has_many :answers, dependent: :destroy
 	

 	validates_presence_of :title, :kind
	accepts_nested_attributes_for :possible_answers, reject_if: proc { |attributes| attributes['title'].blank? }
	accepts_nested_attributes_for :answers, reject_if: proc { |attributes| attributes['title'].blank? }
	


end
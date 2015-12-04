class Reply < ActiveRecord::Base
  belongs_to :poll
  belongs_to :question
  has_many :answers

  accepts_nested_attributes_for :answers
end

class Email < ActiveRecord::Base
	belongs_to :legislator
	validates_presence_of :legislator 
end
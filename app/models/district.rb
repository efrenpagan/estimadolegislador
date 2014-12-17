class District < ActiveRecord::Base
	has_many :senators
	has_many :representatives
end

class DistrictsController < ApplicationController
	has_many :legislators
	has_many :representatives
end

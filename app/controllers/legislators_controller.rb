class LegislatorsController < ApplicationController
	def index
		render json: Legislator.all
	end
end

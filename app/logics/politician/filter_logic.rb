module Politician::FilterLogic
	extend self

	def search query
		Politician.search(query).records
	end
end
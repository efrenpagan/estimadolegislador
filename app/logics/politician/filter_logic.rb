module Politician::FilterLogic
	extend self

	def search(query, filtered_ids)
		params = { 
			query: {
		    filtered: {
		      query: {
		        query_string: { query: "*#{query}*" }
		      },
		      filter: {
		      	not: {
		      		filter:{
		      			ids: {
		      				values: JSON.parse(filtered_ids)
		      			}
		      		}
		      	}
		      }
		    }
		  }
		}

		Politician.search(params).records
	end
end
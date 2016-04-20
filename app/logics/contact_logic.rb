module ContactLogic
	extend self

	def get_by_ids(ids, included)
		if included
			Contact.find(ids).index_by(&:id).slice(*ids).values
		else #excluded ids
			Contact.where.not(id: ids)
		end
	end

	def search(query, excluded_ids)
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
		      				values: JSON.parse(excluded_ids)
		      			}
		      		}
		      	}
		      }
		    }
		  }
		}

		Contact.__elasticsearch__.search(params).records
	end
end

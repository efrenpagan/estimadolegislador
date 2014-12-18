object @legislator
glue :representative do |representative|
	attribute :category
	node :category do |representative|
		if representative.district?
			'Distrito'
		elsif representative.accumulation?
			'Acumulación'
		end
	end
	if representative.district?
		child :district do
			attribute :name
		end
	end
end

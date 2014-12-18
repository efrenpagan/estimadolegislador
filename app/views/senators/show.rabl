object @legislator
glue :senator do |senator|
	attribute :category
	node :category do |senator|
		if senator.district?
			'Distrito'
		elsif senator.accumulation?
			'Acumulación'
		end
	end
	if senator.district?
		child :district do
			attribute :name
		end
	end
end

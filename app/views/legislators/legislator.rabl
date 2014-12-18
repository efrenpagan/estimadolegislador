object @legislator
if root_object.representative?
	extends "representatives/show"
elsif root_object.senator?
	extends "senators/show"
end


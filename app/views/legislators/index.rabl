collection @legislators, :object_root => false
attributes :name, :email
node :role do |legislator|
	if legislator.representative?
		'Representate'
	elsif legislator.senator?
		'Senador'
	end
end
extends "legislators/legislator"
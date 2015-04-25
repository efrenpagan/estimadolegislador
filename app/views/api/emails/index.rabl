collection @emails, :object_root => false
attributes :id, :from_name, :subject, :created_at
child(:legislator) { attributes :name }
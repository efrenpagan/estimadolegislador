collection @messages, :object_root => false
attributes :id, :from_name, :subject, :body_text, :created_at
child(:contacts) { attributes :name }

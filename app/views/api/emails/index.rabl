collection @emails, :object_root => false
attributes :id, :from_name, :subject, :message_text, :created_at
child(:politician) { attributes :name }

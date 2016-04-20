collection @contacts, :object_root => false
attributes :id, :name, :position_description, :internal_position
node(:image) { |contact| contact.image.url }

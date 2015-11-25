object @contact
attributes :id, :name, :position_description, :internal_position, :email, :twitter_handle
node(:image) { |contact| contact.image.url }

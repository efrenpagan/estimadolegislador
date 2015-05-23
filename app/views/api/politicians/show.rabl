object @politician
attributes :id, :name, :description, :role, :political_party, :position
node(:image) { |politician| politician.image.url }
object @politician
attributes :id, :name, :email, :position, :district, :political_party, :branch
node(:image) { |politician| politician.image.url }
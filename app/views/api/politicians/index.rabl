collection @politicians, :object_root => false
attributes :id, :name, :position, :district, :political_party
node(:branch) { |politician| politician.representative? ? "Representante" : "Senador"}
node(:image) { |politician| politician.image.url }
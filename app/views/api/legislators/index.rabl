collection @legislators, :object_root => false
attributes :id, :name, :position, :district, :political_party
node(:branch) { |legislator| legislator.representative? ? "Representante" : "Senador"}
node(:image) { |legislator| legislator.image.url }
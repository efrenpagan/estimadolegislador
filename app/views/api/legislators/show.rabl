object @legislator
attributes :id, :name, :email, :position, :district, :political_party, :branch
node(:image) { |legislator| legislator.image.url }
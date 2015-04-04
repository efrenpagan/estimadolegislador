require 'mechanize'
require "open-uri"

mechanize = Mechanize.new

def extract_name(node)
	text = node.search('.info > .name').text.split
	# Sample text: Hon. Jaime R. Perelló Borrás - Presidente PPD
	text.shift # Remove Hon.
	text.pop # Remove political party
	text = text.take(text.index('-')) if text.include?('-') # Remove role if exist
	text.join(' ')
end

def extract_position(node)
	text = node.search('.info > .name').text.split
	text.shift # Remove Hon.
	text.pop # Remove political party
	text.include?('-') ? text.drop(text.index('-') + 1).join(' ') : nil
end

def extract_political_party(node)
	node.search('.info > .name').text.split.last
end

def extract_district(node)
	node.search('.info > .district').text.split.join(' ')
end

def extract_image_scr(node)
	node.css('span.identity img')[0]['src']
end

page_url = 'http://www.tucamarapr.org'
page = mechanize.get(page_url + '/dnncamara/web/composiciondelacamara.aspx#rep')

page.search('.info-wrap').each do |row|

	name = extract_name(row)
	position = extract_position(row)
	political_party = extract_political_party(row)
	district = extract_district(row)
	image_src = page_url + extract_image_scr(row)

	Legislator.create(name: name, branch: 'representative', position: position, district: district, political_party: political_party, image: URI.parse(image_src))

end
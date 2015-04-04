require 'mechanize'
require 'open-uri'
require 'unicode_utils'

mechanize = Mechanize.new

def rep_extract_name(node)
	text = node.search('.info > .name').text.split
	# Sample text: Hon. Jaime R. Perelló Borrás - Presidente PPD
	text.shift # Remove Hon.
	text.pop # Remove political party
	text = text.take(text.index('-')) if text.include?('-') # Remove role if exist
	text.join(' ')
end

def rep_extract_position(node)
	text = node.search('.info > .name').text.split
	text.shift # Remove Hon.
	text.pop # Remove political party
	text.include?('-') ? text.drop(text.index('-') + 1).join(' ') : nil
end

def rep_extract_political_party(node)
	node.search('.info > .name').text.split.last
end

def rep_extract_district(node)
	node.search('.info > .district').text.split.join(' ')
end

def rep_extract_image_scr(node)
	node.css('span.identity img')[0]['src']
end

page_url = 'http://www.tucamarapr.org'
page = mechanize.get(page_url + '/dnncamara/web/composiciondelacamara.aspx#rep')

page.search('.info-wrap').each do |row|

	name = rep_extract_name(row)
	position = rep_extract_position(row)
	political_party = rep_extract_political_party(row)
	district = rep_extract_district(row)
	image_src = page_url + rep_extract_image_scr(row)

	Legislator.create(name: name, branch: 'representative', position: position, district: district, political_party: political_party, image: URI.parse(image_src))

end

# ---------------------------------------------------

def sen_extract_name(node)
	text = node.search('td')[0].text.split
	text.shift # Remove Hon.
	UnicodeUtils.titlecase(text.join(' '))
end

def sen_extract_position(node)
	node.search('td')[1].text
end

def sen_extract_political_party(node)
	node.search('td')[2].text.split.map { |e| e[0] }.join
end

def sen_extract_email(node)
	node.search('td')[4].text
end

page = mechanize.get('http://senado.pr.gov/senadores/Pages/senadores.aspx')

page.search('table.ms-listviewtable tr').each_with_index do |row, i|
	next if i < 6	
	name = sen_extract_name(row)
	position = sen_extract_position(row)
	political_party = sen_extract_political_party(row)
	email = sen_extract_email(row)
	
	Legislator.create(name: name, branch: 'senate', position: position, political_party: political_party, email: email)

end
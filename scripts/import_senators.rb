require 'mechanize'
require 'unicode_utils'

mechanize = Mechanize.new

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
	
	Politician.create(name: name, branch: 'senate', position: position, political_party: political_party, email: email)

end
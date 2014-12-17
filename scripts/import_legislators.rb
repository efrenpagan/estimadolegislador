require 'mechanize'
require 'unicode_utils'

def extract_name_1(text)
	unsanitized_name = text[0, text.index('Distrito')].strip.gsub(/\s+/, ' ').split
	unsanitized_name.delete_at(-1)
	unsanitized_name = unsanitized_name.join(' ')
	UnicodeUtils.titlecase(unsanitized_name[1, unsanitized_name.length])
end

def extract_name_2(text)
	unsanitized_name = text.split
	unsanitized_name = unsanitized_name.join(' ')
	UnicodeUtils.titlecase(unsanitized_name[1, unsanitized_name.length])
end

def extract_district(text)
	district_number = format('%02d', text.scan(/\d+/)[0].to_i)
	"Distrito Núm: #{district_number}"
end

def extract_email(text)
	regex = /([a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*(@|\sat\s)(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?(\.|\sdot\s))+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)/
	regex.match(text).to_s
end

representantes_url = 'http://www.camaraderepresentantes.org/'
mechanize = Mechanize.new
index_page = mechanize.get(representantes_url + 'cr_legs.asp')

# Representantes por Distrito 
# index_page.search('table.img_news')[0].css("a").each do |link|
# 	begin
# 		individual_page = mechanize.get(representantes_url + link['href'])
# 		name_n_district = individual_page.search('.tbrown').text
# 		name = extract_name_1(name_n_district)
# 		district = extract_district(name_n_district)
# 		email = extract_email(individual_page.body)
# 		puts name
# 		puts district
# 		puts email
# 		puts '---------------------'
# 	rescue Exception => e  
# 		# puts e.message
# 	end
# end

# Representantes por Acumulación
# index_page.search('table.img_news')[1].css("a").each do |link|
# 	individual_page = mechanize.get(representantes_url + link['href'])
# 	name = extract_name_2(individual_page.search('.tbrown').text)
# 	email = extract_email(individual_page.body)
# 	puts name
# 	puts email
#   puts '---------------------'
# end


senadores_url = 'http://senado.pr.gov/senadores/Pages/senadores.aspx'
index_page = mechanize.get(senadores_url)
index_page.search('table.ms-listviewtable > tr').each do |row|
	name = UnicodeUtils.titlecase(row.search('td')[0].text)
	email = row.search('td')[4].text
	puts name
	puts email
	puts '--------------'
end


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

District.destroy_all
Legislator.destroy_all
Representative.destroy_all
Senator.destroy_all

representantes_url = 'http://www.camaraderepresentantes.org/'
mechanize = Mechanize.new
index_page = mechanize.get(representantes_url + 'cr_legs.asp')

# Representantes por Distrito 
index_page.search('table.img_news')[0].css("a").each do |link|
	begin
		individual_page = mechanize.get(representantes_url + link['href'])
		name_n_district = individual_page.search('.tbrown').text
		name = extract_name_1(name_n_district)
		district = extract_district(name_n_district)
		email = extract_email(individual_page.body)
		d = District.create(name: district)
		l = Legislator.create(name: name, email: email, role: :representative)
		Representative.create(legislator: l, district: d, category: :district)
	rescue Exception => e  
		puts e.message
	end
end

# Representantes por Acumulación
index_page.search('table.img_news')[1].css("a").each do |link|
	individual_page = mechanize.get(representantes_url + link['href'])
	name = extract_name_2(individual_page.search('.tbrown').text)
	email = extract_email(individual_page.body)
	l = Legislator.create(name: name, email: email, role: :representative)
	Representative.create(legislator: l, category: :accumulation)
end


# d = District.create(name: 'Distrito Núm: 01')
# l = Legislator.create(name: 'Hon. José López Muñoz', email: 'nunolopez@camaraderepresentantes.org', role: :representative)
# Representative.create(legislator: l, district: d, category: :district)

# Hon. Luis R. Torres Cruz
# Distrito Núm: 02
# ltorres@camaraderepresentantes.org

# Hon. Sonia Pacheco Irigoyen
# Distrito Núm: 03
# spacheco@camaraderepresentantes.org

# Hon. Jose L Baez Rivera
# Distrito Núm: 04
# jbaez@camaraderepresentantes.org

# Hon. Jorge Navarro Suárez
# Distrito Núm: 05
# jnavarro@camaraderepresentantes.org

# Hon. Antonio L. Soto Torres
# Distrito Núm: 06
# ansoto@camaraderepresentantes.org

# Hon. Luis Pérez Ortiz
# Distrito Núm: 07
# lperez@camaraderepresentantes.org

# Hon. Antonio Silva Delgado
# Distrito Núm: 08
# asilva@camaraderepresentantes.org

# Hon. Angel E. Rodríguez Miranda
# Distrito Núm: 09
# angrodriguez@camaraderepresentantes.org

# Hon. Pedro J. Santiago Guzman
# Distrito Núm: 10
# psantiago@camaraderepresentantes.org

# Hon. Rafael Hernández Montañez
# Distrito Núm: 11
# rahernandez@camaraderepresentantes.org

# Hon. Héctor A. Torres Calderón
# Distrito Núm: 12
# hetorres@camaraderepresentantes.org

# Hon. Gabriel Rodríguez Aguiló
# Distrito Núm: 13
# gfrodriguez@camaraderepresentantes.org

# Hon. Ricardo J. Llerandi Cruz
# Distrito Núm: 14
# rllerandi@camaraderepresentantes.org

# Hon. Cesar Hernandez Alfonzo
# Distrito Núm: 15
# cehernandez@camaraderepresentantes.org

# Hon. Jose A. Rodriguez Quiles
# Distrito Núm: 16
# joserodriguez@camaraderepresentantes.org

# Hon. Armando Franco González
# Distrito Núm: 17
# afranco@camaraderepresentantes.org

# Hon. Angel Muñoz Suarez
# Distrito Núm: 18
# amunoz@camaraderepresentantes.org

# Hon. Efrain De Jesus Rodriguez
# Distrito Núm: 19
# edejesus@camaraderepresentantes.org

# Hon. Carlos Bianchi Anglero
# Distrito Núm: 20
# cbianchi@camaraderepresentantes.org

# Hon. Lydia Méndez Silva
# Distrito Núm: 21
# lmendez@camaraderepresentantes.org

# Hon. Waldemar Quiles Rodríguez
# Distrito Núm: 22
# wquiles@camaraderepresentantes.org

# Hon. Nelson Torres Yordan
# Distrito Núm: 23
# njtorres@camaraderepresentantes.org

# Hon. Luis G. León Rodríguez
# Distrito Núm: 24
# lleon@camaraderepresentantes.org

# Hon. Víctor L. Vasallo Anadón
# Distrito Núm: 25
# vvasallo@camaraderepresentantes.org

# Hon. Urayoan Hernandez Alvarado
# Distrito Núm: 26
# uhernandez@camaraderepresentantes.org

# Hon. José R. Torres Ramírez
# Distrito Núm: 27
# jrtorres@camaraderepresentantes.org

# Hon. Rafael Rivera Ortega
# Distrito Núm: 28
# rarivera@camaraderepresentantes.org

# Hon. Carlos J. Vargas Ferrer
# Distrito Núm: 29
# cjvargas@camaraderepresentantes.org

# Hon. Luis R Ortiz Lugo
# Distrito Núm: 30
# lortiz@camaraderepresentantes.org

# Hon. Jesus Santa Rodriguez
# Distrito Núm: 31
# jsanta@camaraderepresentantes.org

# Hon. José M. Varela Fernández
# Distrito Núm: 32
# jvarela@camaraderepresentantes.org

# Hon. Angel R. Peña Ramírez
# Distrito Núm: 33
# anpena@camaraderepresentantes.org

# Hon. Ramón Luis Cruz Burgos
# Distrito Núm: 34
# rcruz@camaraderepresentantes.org

# Hon. Narden Jaime Espinosa
# Distrito Núm: 35
# njaime@camaraderepresentantes.org

# Hon. Carlos “Johnny” Méndez Nuñez
# Distrito Núm: 36
# cmendez@camaraderepresentantes.org

# Hon. Angel Bulerín Ramos
# Distrito Núm: 37
# abulerin@camaraderepresentantes.org

# Hon. Javier Aponte Dalmau
# Distrito Núm: 38
# apontedalmau@camaraderepresentantes.org

# Hon. Roberto Rivera Ruiz De Porras
# Distrito Núm: 39
# rrivera@camaraderepresentantes.org

# Hon. Angel Matos Garcia
# Distrito Núm: 40
# amatos@camaraderepresentantes.org
# ----------------End Representantes por Distrito--------------------


# ----------------Start Representantes por Acumulacion--------------------
# Hon. Jaime R. Perelló Borrás
# jperello@camaraderepresentantes.org

# Hon. Carlos M. Hernández López
# chernandez@camaraderepresentantes.org

# Hon. Luisa Gándara Menéndez
# lgandara@camaraderepresentantes.org

# Hon. Brenda López De Arrarás
# blopez@camaraderepresentantes.org

# Hon. Luis R. Vega Ramos
# lvega@camaraderepresentantes.org

# Hon. Jenniffer A. González Colón
# jgo@camaraderepresentantes.org

# Hon. José F. Aponte Hernández
# japonte@camaraderepresentantes.org

# Hon. Jose E. Melendez Ortiz
# jem@camaraderepresentantes.org

# Hon. Maria M. Charbonier Laureano
# mcharbonier@camaraderepresentantes.org

# Hon. María De Lourdes Ramos Rivera
# lramos@camaraderepresentantes.org

# Hon. Manuel A. Natal Albelo
# mnatal@camaraderepresentantes.org
# ----------------End Representantes por Acumulacion--------------------



# ----------------Start Senadores--------------------
# Hon. Eduardo Bhatia Gautier
# ebhatia@senado.pr.gov
# Acumulacion
# --------------
# Hon. Jose L. Dalmau Santiago
# jldalmau@senado.pr.gov
# Distrito Humacao
# --------------
# Hon. Anibal J. Torres Torres
# ajtorres@senado.pr.gov
# Acumulacion
# --------------
# Hon. Rossana Lopez Leon
# rolopez@senado.pr.gov
# Acumulacion
# --------------
# Hon. Antonio J. Fas Alzamora
# afas@senado.pr.gov
# Acumulacion
# --------------
# Hon. Maria T. Gonzalez Lopez
# mgonzalez@senado.pr.gov
# Distrito Mayagüez
# --------------
# Hon. Jose R. Nadal Power
# jnadal@senado.pr.gov
# Distrito San Juan
# --------------
# Hon. Ramon L. Nieves Perez
# rnieves@senado.pr.gov
# Distrito San Juan
# --------------
# Hon. Miguel A. Pereira Castillo
# mpereira@senado.pr.gov
# Distrito Guayama
# --------------
# Hon. Luis D. Rivera Filomeno
# ldrivera@senado.pr.gov
# Distrito Carolina
# --------------
# Hon. Pedro A. Rodriguez Gonzalez
# prodriguez@senado.pr.gov
# Distrito Carolina
# --------------
# Hon. Angel M. Rodriguez Otero
# anrodriguez@senado.pr.gov
# Distrito Guayama
# --------------
# Hon. Gilberto Rodriguez Valle
# girodriguez@senado.pr.gov
# Distrito Mayagüez
# --------------
# Hon. Angel R. Rosa Rodriguez
# arosa@senado.pr.gov
# Acumulacion
# --------------
# Hon. Ramon Ruiz Nieves
# rruiz@senado.pr.gov
# Distrito Ponce
# --------------
# Hon. Jorge I. Suarez Caceres
# jsuarez@senado.pr.gov
# Distrito Humacao
# --------------
# Hon. Cirilo Tirado Rivera
# ctirado@senado.pr.gov
# Acumulacion
# --------------
# Hon. Martin Vargas Morales
# mvargas@senado.pr.gov
# Distrito Ponce
# --------------
# Hon. Larry Seilhamer Rodriguez
# lseilhamer@senado.pr.gov
# Acumulacion
# --------------
# Hon. Carmelo J. Rios Santiago
# crios@senado.pr.gov
# Distrito Bayamón
# --------------
# Hon. Angel Martinez Santiago
# anmartinez@senado.pr.gov
# Distrito Arecibo
# --------------
# Hon. Margarita Nolasco Santiago
# mnolasco@senado.pr.gov
# Acumulacion
# --------------
# Hon. Migdalia Padilla Alvelo
# mpadilla@senado.pr.gov
# Distrito Bayamón
# --------------
# Hon. Itzamar Peña Ramirez
# ipena@senado.pr.gov
# Acumulacion
# --------------
# Hon. Jose O. Perez Rosa
# josperez@senado.pr.gov
# Distrito Arecibo
# --------------
# Hon. Thomas Rivera Schatz
# trivera@senado.pr.gov
# Acumulacion
# --------------
# Hon. Maria De L. Santiago Negron
# masantiago@senado.pr.gov
# Acumulacion


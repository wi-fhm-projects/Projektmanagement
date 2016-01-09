# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


vollkornbäckerei = Project.create(title: 'Vollkornbäckerei', description: 'Ein Controlling-Projekt')
webprojekt = Project.create(title: 'Webprojekt', description: 'Ein Programmier-Projekt')

#############
##PBS-Seeds##
#############
brezel = Subproduct.create(name: 'Brezel', description: 'Eine Vollkornbrezel', project: vollkornbäckerei)
server = Subproduct.create(name: 'Server', description: 'Server der Host-Applikation', project: webprojekt)

teig = Modul.create(name: 'Teig', description: 'Rohteig', subproduct: brezel)
main_unit = Modul.create(name: 'Main unit', description: 'Recheneinheit', subproduct: server)
monitor = Modul.create(name: 'Monitor', description: 'Ausgabeelement', subproduct: server)
maus = Modul.create(name: 'Maus', description: 'Eingabeelement', subproduct: server)

salz = Component.create(name: 'Salz', description: 'Rohstoff', modul: teig)
zucker = Component.create(name: 'Zucker', description: 'Rohstoff', modul: teig)
pulver = Component.create(name: 'Backpulver', description: 'Rohstoff', modul: teig)
housing = Component.create(name: 'Gehäuse', description: '', modul: main_unit)
housing_2 = Component.create(name: 'Gehäuse', description: '', modul: monitor)
electronics = Component.create(name: 'Elektronik', description: '', modul: maus)


#############
##RBS-Seeds##
#############
produktionsressource = Kind.create(name: 'Produktionsressourcen', project: vollkornbäckerei)
#produktionsleiter = Role.create(name: 'Produktionsleiter', kind: produktionsressource, allocationitem: allo1)
#produktionsarbeiter = Role.create(name: 'Produktionsarbeiter', kind: produktionsressource, allocationitem: allo2)
#qualifikation = Requirement.create(qualifikation: 'Besondere Motivation', experience: '5 Jahre Berufserfahrung', role: produktionsleiter)
#qualifikation_1 = Requirement.create(qualifikation: 'Besondere Motivation', experience: '3 Jahre Berufserfahrung', role: produktionsarbeiter)

#allo1 = Allocationitem.create(component: pulver, role: produktionsleiter)
#allo2 = Allocationitem.create(component: salz,   role: produktionsarbeiter)
#allo3 = Allocationitem.create(component: zucker, role: produktionsarbeiter)
#allo4 = Allocationitem.create(component: pulver, role: produktionsarbeiter)

produktionsressource2 = Kind.create(name: 'Produktionsressourcen', project: webprojekt)
produktionsleiter2 = Role.create(name: 'Produktionsleiter', kind: produktionsressource2)
produktionsarbeiter2 = Role.create(name: 'Produktionsarbeiter', kind: produktionsressource2)
#qualifikation2 = Requirement.create(qualifikation: 'Besondere Motivation', experience: '5 Jahre Berufserfahrung', role: produktionsleiter2)
#qualifikation_12 = Requirement.create(qualifikation: 'Besondere Motivation', experience: '3 Jahre Berufserfahrung', role: produktionsarbeiter2)


#############
##WBS-Seeds##
#############
Task.create(name: '', project: vollkornbäckerei)

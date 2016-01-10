# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#################
##Projekt-Seeds##
#################
vollkornbäckerei = Project.create(title: 'Vollkornbäckerei', description: 'Ein Controlling-Projekt')
webprojekt = Project.create(title: 'Webprojekt', description: 'Ein Programmier-Projekt')


##############
##User-Seeds##
##############

admin = User.create(email: 'admin@pmtool.com',  password: '12345678', first_name: 'John', last_name: 'Cena')
admin.save!


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
##WBS-Seeds##
#############
betriebsfest = Task.create(name: 'Betriebsfest organisieren', project: vollkornbäckerei)

raum = Subtask.create(name: 'Raum', task: betriebsfest)
bewirtung = Subtask.create(name: 'Bewirtung', task: betriebsfest)
programm = Subtask.create(name: 'Programm', task: betriebsfest)
einladung = Subtask.create(name: 'Einladung', task: betriebsfest)

angebote = Workpackage.create(name: 'Angebote einholen', subtask: raum)
besichtigung = Workpackage.create(name: 'Besichtigung', successor_id: angebote.id, subtask: raum)

angebote2 = Workpackage.create(name: 'Angebote einholen', subtask: bewirtung)
essen = Workpackage.create(name: 'Probeessen', successor_id: angebote2.id, subtask: bewirtung)
auftrag = Workpackage.create(name: 'Beauftragung', successor_id: essen, subtask: bewirtung)

brainstorm = Workpackage.create(name: 'Brainstorming', subtask: programm)
angebote3 = Workpackage.create(name: 'Angebote einholen', successor_id: brainstorm.id, subtask: programm)

inhalt = Workpackage.create(name: 'Inhalt definieren', subtask: einladung)
gestalltung = Workpackage.create(name: 'Gestaltung definieren', subtask: einladung)
druck = Workpackage.create(name: 'Druck', subtask: einladung)
versand = Workpackage.create(name: 'Versand', subtask: einladung)


#############
##RBS-Seeds##
#############
produktionsressource = Kind.create(name: 'Produktionsressourcen', project: vollkornbäckerei)
produktionsleiter = Role.create(name: 'Produktionsleiter', kind: produktionsressource)
produktionsarbeiter = Role.create(name: 'Produktionsarbeiter', kind: produktionsressource)

#qualifikation = Requirement.create(qualifikation: 'Besondere Motivation', experience: '5 Jahre Berufserfahrung', role: produktionsleiter)
#qualifikation_1 = Requirement.create(qualifikation: 'Besondere Motivation', experience: '3 Jahre Berufserfahrung', role: produktionsarbeiter)

produktionsressource2 = Kind.create(name: 'Produktionsressourcen', project: webprojekt)
produktionsleiter2 = Role.create(name: 'Produktionsleiter', kind: produktionsressource2)
produktionsarbeiter2 = Role.create(name: 'Produktionsarbeiter', kind: produktionsressource2)
#qualifikation2 = Requirement.create(qualifikation: 'Besondere Motivation', experience: '5 Jahre Berufserfahrung', role: produktionsleiter2)
#qualifikation_12 = Requirement.create(qualifikation: 'Besondere Motivation', experience: '3 Jahre Berufserfahrung', role: produktionsarbeiter2)


####################
##ManyToMany-Seeds##
####################
allo1 = Allocationitem.create(component: pulver, workpackage: angebote, role: produktionsleiter)
allo2 = Allocationitem.create(component: zucker, workpackage: angebote, role: produktionsarbeiter)
produktionsleiter.allocationitem = allo1
produktionsarbeiter.allocationitem = allo2


################
##Delphi-Seeds##
################
#runde1 = Questionary.create(runde: 1, project: vollkornbäckerei)
#runde2 = Questionary.create(runde: 2, project: vollkornbäckerei)

#question1 = Question.create(workpackage: angebote, questionary: runde1)
#question2 = Question.create(workpackage: brainstorm, questionary: runde2)

#response1 = Response.create(pessimistic: 15, realistic: 10, optimistic: 5, question: question1, user: admin)
#response2 = Response.create(pessimistic: 20, realistic: 15, optimistic: 10, question: question1, user: admin)

#response3 = Response.create(pessimistic: 15, realistic: 10, optimistic: 5, question: question2, user: admin)
#response4 = Response.create(pessimistic: 20, realistic: 15, optimistic: 10, question: question2, user: admin)

#Userquest.create(questionary: runde1, user: admin)
#Userquest.create(questionary: runde2, user: admin)


#################
##Roadmap-Seeds##
#################
#event1 = Event.create(startDate: Date.new(2016, 2, 11), project: vollkornbäckerei, questionarys_id: runde1.id)
#event2 = Event.create(startDate: Date.new(2016, 3, 28), project: vollkornbäckerei, questionarys_id: runde2.id)

# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# par cinnosti ktore koresponduju s backendom
[
 "automatizované spracovanie dát ",
 "služby databánk",
 "správa sietí",
 "sprostredkovateľská činnosť v rozsahu predmetu podnikania",
 "školiaca a konzultačná činnosť v rozsahu predmetu podnikania",
 "finančný lízing",
 "uloženie vecí",
 "funkciu depozitára",
 "poskytovanie bankových informácií"
].each { |r| Operation.create(:popis => r) }

# pouzivatel l:"test" p:"testtest" s profilom
user = User.new
user.id = 99
user.login = "test"
user.pass = "testtest"
user.email = "test@test.com"
user.save
Profile.create(
               :meno => "Jozef",
               :priez => "Mrkvička",
               :t_pred => "Ing.",
               :t_za => "Csc.",
               :ulica => "Nevädzova",
               :cislo => "14",
               :obec => "Bratislava",
               :psc => "87524",
               :stat => "Slovenská republika",
               :user_id => "99")

# testovacia srocka
sro = Sro.new
sro.id = 999
sro.nazov = "Test s.r.o."
sro.ulica = "Štefánikova"
sro.cislo = "18"
sro.obec = "Trenčín"
sro.psc = "11111"
sro.stat = "Slovenská Republika"
sro.forma = "sro"
sro.imanie = "5000"
sro.splatene = "5000"
sro.proces = "step2"
sro.user_id = "99"
sro.save
# spolocnik
Person.create(
              :t_pred => "Ing.",
              :meno => "Michal",
              :priez => "Veselý",
              :t_za  => "",
              :ulica => "Drevená",
              :cislo  => "5",
              :obec => "Trenčín",
              :psc => "11111",
              :stat => "Slovenská Republika",
              :typ => "1",
              :dat_nar => "1",
              :rc => "830725/6578",
              :vklad => "5000",
              :splatene => "5000",
              :sposob => "a",
              :sro_id => "999")
# konatel ten isty - typ 2
Person.create(
              :t_pred => "Ing.",
              :meno => "Michal",
              :priez => "Veselý",
              :t_za  => "",
              :ulica => "Drevená",
              :cislo  => "5",
              :obec => "Trenčín",
              :psc => "11111",
              :stat => "Slovenská Republika",
              :typ => "2",
              :dat_nar => "07-04-1980",
              :rc => "800407/3678",
              :vklad => "1",
              :splatene => "1",
              :sposob => "Podpisuje v mene spoločnosti samostatne.",
              :funkcia_od => Time.now,
              :sro_id => "999")
# dozorna rada
Person.create(
              :t_pred => "Ing.",
              :meno => "Petra",
              :priez => "Valachovská",
              :t_za  => "",
              :ulica => "Drevená",
              :cislo  => "8",
              :obec => "Trenčín",
              :psc => "11111",
              :stat => "Slovenská Republika",
              :typ => "3",
              :dat_nar => "12-11-1975",
              :rc => "755112/3078",
              :vklad => "1",
              :splatene => "1",
              :sposob => "a",
              :funkcia_od => Time.now,
              :sro_id => "999")
Person.create(
              :t_pred => "Ing.",
              :meno => "Jozef",
              :priez => "Valachovský",
              :t_za  => "Phd.",
              :ulica => "Drevená",
              :cislo  => "8",
              :obec => "Trenčín",
              :psc => "11111",
              :stat => "Slovenská Republika",
              :typ => "3",
              :dat_nar => "07-02-1975",
              :rc => "750207/3008",
              :vklad => "1",
              :splatene => "1",
              :sposob => "a",
              :funkcia_od => Time.now,
              :sro_id => "999")
Person.create(
              :t_pred => "Ing.",
              :meno => "Milan",
              :priez => "Schwartz",
              :t_za  => "",
              :ulica => "Fuldermannova",
              :cislo  => "25",
              :obec => "Trenčín",
              :psc => "11111",
              :stat => "Slovenská Republika",
              :typ => "3",
              :dat_nar => "12-09-1966",
              :rc => "660912/3147",
              :vklad => "1",
              :splatene => "1",
              :sposob => "a",
              :funkcia_od => Time.now,
              :sro_id => "999")



class Profil < ActiveRecord::Base
  # vztah k uzivatelovi
  belongs_to :user
  
  # validacie formulara pred vlozenim do databazy
  validates :meno, :presence => true
  validates :priez, :presence => true
  validates :ulica, :presence => true
  validates :cislo, :presence => true, :numericality => true
  validates :obec, :presence => true
  validates :psc, :presence => true, :numericality => true
  validates :stat, :presence => true
  
end

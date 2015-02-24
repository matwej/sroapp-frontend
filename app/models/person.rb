# -*- encoding : utf-8 -*-
class Person < ActiveRecord::Base
  
  PSC_RGXP = %r"[0-9]{6}/[0-9]{4}"
  
  validates :meno, :presence => true
  validates :priez, :presence => true
  validates :rc, :presence => true, :format => PSC_RGXP
  validates :ulica, :presence => true
  validates :cislo, :presence => true, :numericality => true
  validates :obec, :presence => true
  validates :psc, :presence => true, :numericality => true
  validates :stat, :presence => true
  validates :sposob, :presence => true
  validates :typ, :presence => true
  validates :vklad, :presence => true, :numericality => true
  validates :splatene, :presence => true, :numericality => true
  
end

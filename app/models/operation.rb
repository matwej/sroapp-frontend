# -*- encoding : utf-8 -*-
class Operation < ActiveRecord::Base
  has_many :opandsros
  has_many :sros, through: :opandsros
  
  validates :popis, :presence => true, :uniqueness => true
end

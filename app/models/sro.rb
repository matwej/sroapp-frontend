# -*- encoding : utf-8 -*-
class Sro < ActiveRecord::Base
  
  has_many :opandsros
  has_many :operations, through: :opandsros
  has_many :people
  
  accepts_nested_attributes_for :operations

  validates :nazov, :presence => true, :uniqueness => true
  validates :ulica, :presence => true
  validates :cislo, :presence => true, :numericality => true
  validates :obec, :presence => true
  validates :psc, :presence => true, :numericality => true
  validates :stat, :presence => true
  validates :imanie, :numericality => {greater_than_or_equal_to: 5000, only_integer: true}, :on => :update
  validates :splatene, :numericality => {greater_than_or_equal_to: 2500, only_integer: true}, :on => :update
  
end

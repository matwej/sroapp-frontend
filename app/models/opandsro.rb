# -*- encoding : utf-8 -*-
class Opandsro < ActiveRecord::Base
  belongs_to :sro
  belongs_to :operation
end

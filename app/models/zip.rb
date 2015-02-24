# -*- encoding : utf-8 -*-
class Zip < ActiveRecord::Base
  belongs_to :sro
  
  mount_uploader :file, ZipUploader
  
  def file=(obj)
    super(obj)
  end
end

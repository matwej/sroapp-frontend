# -*- encoding : utf-8 -*-
class CreateZips < ActiveRecord::Migration
  def change
    create_table :zips do |t|
      t.string :file
      t.belongs_to :sro
      t.timestamps
    end
  end
end

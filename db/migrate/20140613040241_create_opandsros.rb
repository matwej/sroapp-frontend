# -*- encoding : utf-8 -*-
class CreateOpandsros < ActiveRecord::Migration
  def change
    create_table :opandsros do |t|
      t.belongs_to :sro
      t.belongs_to :operation
      t.timestamps
    end
  end
end

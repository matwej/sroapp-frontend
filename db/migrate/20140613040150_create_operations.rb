# -*- encoding : utf-8 -*-
class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.text :popis

      t.timestamps
    end
  end
end

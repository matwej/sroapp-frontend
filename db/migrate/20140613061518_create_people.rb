# -*- encoding : utf-8 -*-
class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :t_pred
      t.string :meno
      t.string :priez
      t.string :t_za
      t.string :ulica
      t.integer :cislo
      t.string :obec
      t.integer :psc
      t.string :stat
      t.integer :typ
      t.date :dat_nar
      t.string :rc
      t.integer :vklad
      t.integer :splatene
      t.text :sposob
      t.date :funkcia_od
      t.belongs_to :sro
      t.timestamps
    end
  end
end

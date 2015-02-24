# -*- encoding : utf-8 -*-
class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :meno
      t.string :priez
      t.string :t_pred
      t.string :t_za
      t.string :ulica
      t.integer :cislo
      t.string :obec
      t.integer :psc
      t.string :stat
      t.belongs_to :user
      t.timestamps
    end
  end
end

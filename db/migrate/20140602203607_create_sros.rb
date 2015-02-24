# -*- encoding : utf-8 -*-
class CreateSros < ActiveRecord::Migration
  def change
    create_table :sros do |t|
      t.string :nazov
      t.string :ulica
      t.integer :cislo
      t.string :obec
      t.integer :psc
      t.string :stat
      t.string :ico
      t.string :forma
      t.integer :imanie
      t.integer :splatene
      t.string :proces
      t.boolean :schvalene
      t.belongs_to :user
      t.timestamps
    end
  end
end

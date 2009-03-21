class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :titre
      t.text :corps
      t.integer :etat
      t.integer :compte_emetteur
      t.integer :compte_recepteur

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end

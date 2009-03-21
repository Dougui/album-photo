class CreateGroupes < ActiveRecord::Migration
  def self.up
    create_table :groupes do |t|
      t.string :titre
      t.text :description
      t.string :public
      t.string :avatar
      t.integer :compte_id

      t.timestamps
    end
  end

  def self.down
    drop_table :groupes
  end
end

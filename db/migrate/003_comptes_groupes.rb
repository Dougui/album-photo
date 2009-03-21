class ComptesGroupes < ActiveRecord::Migration
  def self.up
    create_table :comptes_groupes, :id => false do |t|
      t.column :compte_id, :integer
      t.column :groupe_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :comptes_groupes
  end
end

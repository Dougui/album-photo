class Commentaire < ActiveRecord::Migration
  def self.up
    create_table :commentaires do |t|
      t.column :pseudo, :string
      t.column :corps, :text
      t.column :compte_id, :integer
      t.column :objet_type, :string
      t.column :objet_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :commentaires
  end
end

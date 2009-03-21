class Initial < ActiveRecord::Migration
  def self.up
    create_table :comptes do |t|
      t.column :pseudo, :string
      t.column :mail, :string
      t.column :mdp, :string
      t.column :description, :text
      t.column :avatar, :string
      t.column :droits, :string, :default => 0
      t.timestamps
    end
    
    create_table :albums do |t|
      t.column :titre, :string
      t.column :description, :text
      t.column :type, :string
      t.column :categorie_id, :integer
      t.column :compte_id, :integer
      t.timestamps
    end
    
    create_table :photos do |t|
      t.string :titre
      t.text :description
      t.integer :parent_id
      t.string :content_type
      t.string :filename
      t.string :thumbnail
      t.integer :size
      t.integer :width
      t.integer :height
      t.integer :album_id
      t.timestamps
    end
    
    create_table :categories do |t|
      t.column :titre, :string
      t.column :description, :text
      t.timestamps
    end
    
    create_table :news do |t|
      t.column :titre, :string
      t.column :corps, :text
      t.column :compte_id, :integer
      t.timestamps
    end
    
    create_table :amis, :id => false do |t|
      t.column :compte1, :integer
      t.column :compte2, :integer
      t.timestamps
    end
    
    create_table :visi_album_comptes, :id => false do |t|
      t.column :compte_id, :integer
      t.column :album_id, :integer
      t.timestamps
    end
    
    create_table :visi_album_groupes, :id => false do |t|
      t.column :groupe_id, :integer
      t.column :album_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :amis
    drop_table :visi_album_groupes
    drop_table :visi_album_comptes
    drop_table :news
    drop_table :categories
    drop_table :photos
    drop_table :albums
    drop_table :comptes
  end
end

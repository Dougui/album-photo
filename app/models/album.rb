class Album < ActiveRecord::Base
  has_one :categorie
  has_many :visi_album_groupes, :dependent => :destroy
  has_many :visi_album_comptes, :dependent => :destroy
  has_many :photos, :dependent => :destroy
  has_one :compte    
  has_and_belongs_to_many :comptes
  has_and_belongs_to_many :groupes
  cattr_reader :per_page
  @@per_page = 10

  
  validates_presence_of :titre, :message => "Le titre est requis"
end

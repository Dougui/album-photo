class Categorie < ActiveRecord::Base
  has_many :albums
  validates_presence_of :titre, :message => "Le titre est requis"  
  cattr_reader :per_page
  @@per_page = 30
end

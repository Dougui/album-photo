class New < ActiveRecord::Base
  has_one :compte
  
  validates_presence_of :titre, :message => "Le titre est requis"
  validates_presence_of :description, :message => "La description est requise"
  validates_presence_of :corps, :message => "Le corps est requis"
  
  cattr_reader :per_page
  @@per_page = 10
end

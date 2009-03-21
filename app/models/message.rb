class Message < ActiveRecord::Base
  belongs_to :comptes
  cattr_reader :per_page
  @@per_page = 10
  
  belongs_to :compte1, :foreign_key => 'compte_emetteur'
  belongs_to :compte2, :foreign_key => 'compte_recepteur'
  
  validates_presence_of :titre, :corps
end

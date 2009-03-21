class Commentaire < ActiveRecord::Base
  belongs_to :compte
  validates_presence_of :pseudo, :message => "Pseudo requis"
#  validates_presence_of :corps, :message => "Message requis"
  
#  validates_exclusion_of :pseudo, :in => Compte.find(:all).collect(&:pseudo), :case_sensitive => false , :message => "Le pseudo existe déjà"
end

class Groupe < ActiveRecord::Base
  has_one :compte
  has_and_belongs_to_many :comptes
  has_and_belongs_to_many :albums
end

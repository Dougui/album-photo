class Compte < ActiveRecord::Base
    
  require "RMagick"
  include Magick

  has_and_belongs_to_many :albums
  has_and_belongs_to_many :groupes
  has_many :commentaires
  has_many :groupes
  has_many :albums, :dependent => :destroy
  has_many :amis, :foreign_key => 'compte1', :dependent => :destroy
  has_many :amis, :foreign_key => 'compte2', :dependent => :destroy
  has_many :news
  has_many :visi_album_comptes, :dependent => :destroy
  has_many :messages, :foreign_key => 'compte_emetteur'
  has_many :messages, :foreign_key => 'compte_recepteur'
  
  validates_presence_of :pseudo, :message => "Pseudo requis"
  validates_uniqueness_of :pseudo, :case_sensitive => true, :message => "Pseudo déjà utilisé"
  validates_presence_of :mail, :message => "Adresse E-Mail requise"
  validates_uniqueness_of :mail, :case_sensitive => true, :message => "Adresse E-Mail utilisée"
  validates_format_of :mail, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :messsage => "Format incorrect"
  
  cattr_reader :per_page
  @@per_page = 10
#  def verif(params)
#    message = "Une erreur à été commise : <br>"
#    erreur = false
#    if pseudo.empty?
#      message += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Le pseudo est manquant.<br>"
#      erreur = true
#    elsif Compte.find_by_pseudo(pseudo, :conditions => "id <> '#{params[:id]}'")
#
#      message += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Le Pseudo est déjà utilisé.<br>"
#      erreur = true
#    end
#    if mail.empty?
#      message += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L'adresse e-mail est manquante.<br>"
#      erreur = true
#    elsif (mail.to_s =~ /(\A(\s*)\Z)|(\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z)/i) == nil
#      message += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L'email est au mauvais format.<br>"
#      erreur = true
#    elsif Compte.find_by_mail(mail, :conditions => "id <> '#{params[:id]}'")
#      message += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L'adresse E-mail est déjà utilisée.<br>"
#      erreur = true
#    end
#    if mdp.empty? and params[:mdp1].empty?
#      message += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Les mots de passes sont manquants.<br>"
#      erreur = true
#    elsif mdp != params[:mdp1]
#      message += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Les mots de passes sont différents<br>"
#      erreur = true
#    end
#    
#    if !erreur
#      message = ""
#    end 
#    return message
#  end

  
  def resize_image(filename = nil, filedest = nil, sizemax = 640)
    img = Image.read(filename).first
    ratio = sizemax / img.columns.to_f 
    if img.columns.to_f >= img.rows.to_f
      ratio = sizemax / img.rows.to_f 
    elsif img.columns.to_f <= img.rows.to_f
     img = img.scale(ratio) 
    end
    thumbnail = img.thumbnail(img.columns*ratio, img.rows*ratio)
    thumbnail.write filedest
   end
end

class GroupesController < ApplicationController
  require 'rexml/document'
  include REXML
    
  # GET /groupes
  # GET /groupes.xml
  def index
    
    if params[:compte_id] == nil
      @groupes = Groupe.find(:all, :conditions => "public = 1")
    else
      @groupes = Comptes_groupe.find_by_compte_id(params[:compte_id]).groupe
    end
    session[:titre] = "Liste des groupes"
  end

  # GET /groupes/1
  # GET /groupes/1.xml
  def show
    @groupe = Groupe.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @groupe }
    end
  end

  # GET /groupes/new
  # GET /groupes/new.xml
  def new
    @groupe = Groupe.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @groupe }
    end
  end

  # GET /groupes/1/edit
  def edit
    @groupe = Groupe.find(params[:id])
  end

  # POST /groupes
  # POST /groupes.xml
  def create
    doc = Document.new(params[:groupes])
    root = doc.root
    tab = Array.new
    
    root.each_element('//groupe'){|groupe|
    
      newGroupe = Groupe.new
      
      newGroupe.titre = groupe.elements["titre"].text
      newGroupe.compte_id = 1
      if groupe.elements["description"] != nil
        newGroupe.description = groupe.elements["description"].text
      end
      if groupe.elements["public"] != nil
         newGroupe.public = groupe.elements["public"].text
      end
      if groupe.elements["avatar"] != nil
         newGroupe.avatar = groupe.elements["avatar"].text
      end
      
      
      if groupe.elements["id"] == nil
        newGroupe.save
      else
        tab[groupe.elements["id"].text.to_i] = groupe.elements["id"].text
        oldGroupe = Groupe.find(groupe.elements["id"].text)
        oldGroupe.update_attributes(newGroupe.attributes)
        newGroupe = oldGroupe
      end
      
      groupe.each_element('//compte'){|cpt|
         compte = Compte.find(cpt.elements["id"].text.to_i)
         newGroupe.comptes << compte
      }
      

    }
    ids = Array.new(params[:deleteGroupes].split(","))
    for i in 0..ids.length-1
      if(ids[i] != "")
        groupe = Groupe.find(ids[i])
        groupe.destroy
      end
    end
#    groupes = Groupe.find_all_by_compte_id(1);
#    for groupe in groupes
#      puts tab
#      if tab[groupe.id] == nil
#        groupe.destroy
#      end
#    end
    render(:text => true)
  end

  # PUT /groupes/1
  # PUT /groupes/1.xml
  def update
    @groupe = Groupe.find(params[:id])

    respond_to do |format|
      if @groupe.update_attributes(params[:groupe])
        flash[:notice] = 'Groupe was successfully updated.'
        format.html { redirect_to(@groupe) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @groupe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groupes/1
  # DELETE /groupes/1.xml
  def destroy
    @groupe = Groupe.find(params[:id])
    commentaires = Commentaire.find(:all, :conditions => "objet_type = 'album' and objet_id = "+@album.id.to_s)
    commentaires.detroy

#    commentaires = Commentaires
#    for i in 0
    @groupe.destroy

    respond_to do |format|
      format.html { redirect_to(groupes_url) }
      format.xml  { head :ok }
    end
  end
end

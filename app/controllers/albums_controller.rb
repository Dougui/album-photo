class AlbumsController < ApplicationController
  def index   
    if(params[:recherche] != nil)
      if(params[:recherche][:categorie_id] != "" )
        @albums = Album.paginate :all, :conditions => "(titre like '%"+params[:recherche][:album]+"%' or description like '%"+params[:recherche][:album]+"%') and categorie_id = "+params[:recherche][:categorie_id].to_s, :page => params[:page]
      elsif
        @albums = Album.paginate(:all, :conditions => "titre like '%"+params[:recherche][:album]+"%' or description like '%"+params[:recherche][:album]+"%'", :page => params[:page])
      end
      session[:titre] = "Liste des albums"
    elsif(params[:compte_id] == nil && params[:categorie_id] == nil)
      @albums = Album.paginate :all, :conditions => "public = 1", :page => params[:page]
      session[:titre] = "Liste des albums"
    elsif params[:categorie_id] != nil
      @albums = Album.paginate_all_by_categorie_id(params[:categorie_id], :conditions => "public = 1", :page => params[:page])
      session[:titre] = "Liste des albums"
    elsif params[:prive] != nil
      sql = "select a.* from groupes g, comptes_groupes cg, albums a, groupes_albums ga"
      sql+= "where g.id = cg.groupe_id"
      sql+= "and a.id = ga.album_id"
      sql+= "and g.id = ga.groupe_id"
      sql+= "and cg.compte_id = "+params[:compte][:id]
      sql+= "union ("
      sql+= "select a.* from albums a, comptes_albums ca, comptes c"
      sql+= "where a.id = ca.album_id"
      sql+= "and ca.compte_id = "+params[:compte][:id]
      @albums = Album.paginate_by_sql(sql, :page => params[:page])
      session[:titre] = "Liste des albums privés"
    else
      @albums = Album.paginate_all_by_compte_id(session[:compte][:id], :page => params[:page])
      session[:titre] = "Liste de ses albums"
    end
  end

  def show
    @album = Album.find(params[:id])
    session[:titre] = @album.titre
  end

  def new
    @album = Album.new
    session[:titre] = "Créer un album"
  end

  def create
    # Standard, one-at-a-time, upload action
    @album = Album.new(params[:album])
    @album.compte_id = session[:compte][:id]
    if @album.save
      redirect_to :action => :edit, :id => @album.id
    else
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @album = Album.find(params[:id])
    session[:titre] = "Edition : "+@album.titre
  end
  
  def update
    @album = Album.find(params[:album][:id])
    if @album.update_attributes(params[:album])
      redirect_to :controller => :albums,:action => :index, :compte_id => session[:compte].id
    else
      respond_to do |format|
        format.html { render :action => "edit" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @album = Album.find(params[:id])
    Commentaire.delete_all(:objet_id => @album.id, :objet_type => "album")
    @album.destroy
    redirect_to :action => :index, :compte_id => session[:compte][:id]
  end
end

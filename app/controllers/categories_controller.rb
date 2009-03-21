class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.xml
  def index
    @categories = Categorie.paginate(:all, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
      format.js  { render :js => @categories }
    end
    
    session[:titre] = "Liste des categories"
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @categorie = Categorie.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @categorie }
    end
    session[:titre] = @categorie.titre
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @categorie = Categorie.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @categorie }
    end
    session[:titre] = "Créer une categorie"
  end

  # GET /categories/1/edit
  def edit
    @categorie = Categorie.find(params[:id])
    session[:titre] = "Edition : "+@categorie.titre
  end

  # POST /categories
  # POST /categories.xml
  def create
    @categorie = Categorie.new(params[:categorie])

    if @categorie.save
      redirect_to :action => :index
    else
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => @categorie.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @categorie = Categorie.find(params[:categorie][:id])

    if @categorie.update_attributes(params[:categorie])
      redirect_to :action => :index
    else
      respond_to do |format|
        format.html { render :action => "edit" }
        format.xml  { render :xml => @categorie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @categorie = Categorie.find(params[:id])
    @categorie.destroy
  end
  
end

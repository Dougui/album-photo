class NewsController < ApplicationController
  def index
    @news = New.paginate(:all, :page => params[:page])
    session[:titre] = "Derniéres nouvelles"
  end
  

  def show
    @new = New.find(params[:id])
    session[:titre] = @new.titre
  end

  def new
    @new = New.new
    session[:titre] = "Créer une news"
  end

  def create
    @new = New.new(params[:new])
    if @new.save
      redirect_to :action => :index
    else
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => @new.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @new = New.find(params[:id])
    session[:titre] = "Edition : "+@new.titre
  end
  
  def update
    @new = New.find(params[:new][:id])
    if @new.update_attributes(params[:new])
      redirect_to :controller => :news,:action => :index
    else
      respond_to do |format|
        format.html { render :action => "edit" }
        format.xml  { render :xml => @new.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @new = New.find(params[:id])
    @new.destroy
    redirect_to :action => :index
  end
end

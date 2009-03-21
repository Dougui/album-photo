class ComptesController < ApplicationController
  # GET /comptes
  # GET /comptes.xml
  def index
    if params[:pseudo] != nil
      @comptes = Compte.paginate(:all, :conditions => "pseudo like '%"+params[:pseudo]+"%'", :page => params[:page])
    else
      @comptes = Compte.paginate(:all, :page => params[:page])
    end
    session[:titre] = "Liste des comptes"
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @compte }
    end
  end

  # GET /comptes/1
  # GET /comptes/1.xml
  def show
    @compte = Compte.find(params[:id])
    session[:titre] = @compte.pseudo
  end

  # GET /comptes/new
  # GET /comptes/new.xml
  def new
    @compte = Compte.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @compte }
    end
    session[:titre] = "Inscription"
  end

  # GET /comptes/1/edit
  def edit
    @compte = Compte.find(params[:id])
    session[:titre] = "Edition : "+@compte.pseudo
  end

  # POST /comptes
  # POST /comptes.xml
  def create
    
    @compte = Compte.new(params[:compte])
#    message =  @compte.verif(params)
#    if message == ""
      if !@compte.avatar.to_s.empty?
        @compte.avatar = params[:compte][:avatar].original_filename
      end
      if @compte.save
        if !@compte.avatar.to_s.empty?
          directory = RAILS_ROOT + "/public/photos/avatars"
          
          path = File.join(directory,  @compte.id.to_s+"_"+@compte.avatar)
          path_thumb = File.join(directory,  @compte.id.to_s+"_thumb_"+@compte.avatar)
          path_medium = File.join(directory,  @compte.id.to_s+"_medium_"+@compte.avatar)
          
          File.open(path, "wb") { |f| f.write(params[:compte][:avatar].read) }
          
          @compte.resize_image path,path_thumb,100
          @compte.resize_image path,path_medium,600
          @compte.resize_image path,path,800
          
        end
        redirect_to :action => :index
      else
        respond_to do |format|
          format.html { render :action => "new" }
          format.xml  { render :xml => @compte.errors, :status => :unprocessable_entity }
        end
      end
      #    else
#      flash[:message] = message
#      redirect_to :action => :new
#    end  
  end

  # PUT /comptes/1
  # PUT /comptes/1.xml
  def update
    @compte = Compte.new(params[:compte])
    @compteOld = Compte.find(params[:id])

    directory = "public/photos/avatars"
    if File.exist?(directory+"/"+@compteOld.id.to_s+"_"+@compteOld.avatar)
      FileUtils.rm(directory+"/"+@compteOld.id.to_s+"_"+@compteOld.avatar)
      FileUtils.rm(directory+"/"+@compteOld.id.to_s+"_medium_"+@compteOld.avatar)
      FileUtils.rm(directory+"/"+@compteOld.id.to_s+"_thumb_"+@compteOld.avatar)
    end

    if(!@compte.avatar.to_s.empty? && params[:compte][:avatar].original_filename)
      @compte.avatar = params[:compte][:avatar].original_filename
      path = File.join(directory,  @compteOld.id.to_s+"_"+@compte.avatar)
      path_thumb = File.join(directory,  @compteOld.id.to_s+"_thumb_"+@compte.avatar)
      path_medium = File.join(directory,  @compteOld.id.to_s+"_medium_"+@compte.avatar)
     
      File.open(path, "wb") { |f| f.write(params[:compte][:avatar].read) }
      @compte.resize_image path,path_thumb,100
      @compte.resize_image path,path_medium,600
      @compte.resize_image path,path,800
      
    else
      @compte.avatar = @compteOld.avatar
    end
    @compte.created_at = @compteOld.created_at
    if @compteOld.update_attributes(@compte.attributes)
      redirect_to :action => :index
    else
      respond_to do |format|
        format.html { render :action => "edit", :id => @compteOld.id }
        format.xml  { render :xml => @compte.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comptes/1
  # DELETE /comptes/1.xml
  def destroy
    directory = "public/photos/avatars"
    @compte = Compte.find(params[:id])
    if File.exist?(directory+"/"+params[:id]+"_"+@compte.avatar)
      FileUtils.rm(directory+"/"+params[:id]+"_thumb_"+@compte.avatar)
      FileUtils.rm(directory+"/"+params[:id]+"_medium_"+@compte.avatar)
      FileUtils.rm(directory+"/"+params[:id]+"_"+@compte.avatar)
    end
    @compte.destroy
    redirect_to :action => :index
  end
  
  def connection
    if(@compte = Compte.find_by_pseudo(params[:compte][:mdp], :conditions => "mdp = '#{params[:compte][:mdp]}'"))
      @compteNew = Compte.new(@compte.attributes)
      @compteNew.id = @compte.id
      session[:compte] = @compteNew
    end
    
    render(:update) do |page|
       page.replace_html('menuConnection',:partial => "menuConnection")
       page.replace_html('left',:partial => "menu")
    end
  end

 
  def deconnection
    session[:compte] = nil
    render(:update) do |page|
       page.replace_html('menuConnection',:partial => "menuConnection")
       page.replace_html('left',:partial => "menu")
    end
  end
  
  def groupes
     groupes = Compte.find(params[:id]).groupes
     render(:text => groupes.to_xml(:include => :comptes))
  end

end

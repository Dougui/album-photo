class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.xml
  def index
    if(params[:emetteur_id])
      @mode = "emis"
      @messages = Message.paginate_all_by_compte_emetteur(params[:emetteur_id], :page => params[:page])
    else
      @mode = "reçus"
      @messages = Message.paginate_all_by_compte_recepteur(params[:recepteur_id], :page => params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])
    @message.etat = 1
    
    @message.update_attributes(@message.attributes)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])
    @message.compte_emetteur = session[:compte][:id]
    respond_to do |format|
      if @message.save
        flash[:notice] = 'Message was successfully created.'
        format.html { redirect_to(@message) }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
#  def update
#    @message = Message.find(params[:id])
#
#    respond_to do |format|
#      if @message.update_attributes(params[:message])
#        flash[:notice] = 'Message was successfully updated.'
#        format.html { redirect_to(@message) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end
end

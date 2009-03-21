class AmisController < ApplicationController
  def index
    @amis = Ami.find_by_sql("select * from amis where compte1 = "+params[:id]+" or compte2"+params[:id])
  end
  
  def create
    @ami = new Ami
    @ami.compte1 = params[:id]
    @ami.compte2 = session[:compte][:id]
    @ami.save
  end
  
  def delete
    @amis = Ami.find_by_sql("select * from amis where compte1 = "+params[:id]+" or compte2"+params[:id])
    @message.delete
  end 
end

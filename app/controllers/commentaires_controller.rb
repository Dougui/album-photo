class CommentairesController < ApplicationController
  
  def create
    @commentaire = Commentaire.new(params[:commentaire])
    if @commentaire.save
      respond_to do |format|
        format.html {
           render(:update) do |page|
             page.insert_html(:bottom, 'commentaire',:partial => 'commentaires/show', :locals => {:commentaire => @commentaire, :droits => params[:droits], :blind => true} )
             page.visual_effect(:blind_down, "comment_"+@commentaire.id.to_s )
           end
        }
        format.xml  { render :xml => @commentaire.errors, :status => :unprocessable_entity }
      end
    else
      respond_to do |format|
        format.html {
           render(:update) do |page|
             page.replace_html('formCommentaire',:partial => "commentaires/new", :locals => {:type_objet => "album", :droits => params[:droits]})
           end
        }
        format.xml  { render :xml => @commentaire.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def delete
    @commentaire = Commentaire.find(params[:id])
    @commentaire.destroy
    if request.xhr?
     render :text => "true"
    end
  end  
  
  def delete_all
    commentaires = Commentaire.find(:all, :conditions => 'objet_type = \''+params[:objet_type]+'\' and objet_id='+params[:objet_id])
    for commentaire in commentaires
      commentaire.destroy
    end
    if request.xhr?
     render :text => "true"
    end
  end
end

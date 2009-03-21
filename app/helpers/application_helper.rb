# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
 def winput(input_name, options={})
   pre_options = {
     :markup_scheme => "<p><label>%s: %s</label></p>",
     :text => input_name.capitalize.gsub('_',' '),
     :form_name => 'form',
     :options => {}
   }
   o = pre_options.merge(options)
   markup = text_field o[:form_name], input_name, o[:options]
   return sprintf(o[:markup_scheme], o[:text], markup)
 end
 
  def commentaire(object, type) 
    if session[:compte] != nil && (session[:compte].droits.to_i == 9 || object.compte_id == session[:compte].id)
      droits = true
    else
      droits = false
    end
    render(:partial => "commentaires/commentaires", :locals => {:object => object, :droits => droits, :type => type})
  end

  def titre(titre,object, verif = nil)
     result = ''
     result << titre+" | "
      if session[:compte] != nil && session[:compte].droits.to_i == 9  or (verif == nil && verif != session[:compte].id)
        result << link_to('Supprimer', {:action => :destroy, :id => object.id}, :confirm => 'Etes vous sure?', :method => :delete)
        result << " | "
        result << link_to('Editer', {:action => :edit, :id => object.id})
    end
    return result
  end
end

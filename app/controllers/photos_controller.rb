class PhotosController < ApplicationController

  # FIXME: Pass sessions through to allow cross-site forgery protection
  protect_from_forgery :except => :swfupload
  
  def index
   @photos = Photo.find_by_album_id(params[:albums_id])
  end
 
  def getThumb
   photos = Photo.find_by_album_id(params[:id])
   @thumb = Photo.find_by_parent_id(photos.id)
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create
    # Standard, one-at-a-time, upload action
    @photo = Photo.new(params[:photo])
    @photo.save
    redirect_to photos_url
  rescue
    render :action => :new
  end

  def swfupload
    # swfupload action set in routes.rb
    @photos = Photo.new :uploaded_data => params[:Filedata]
        
    @photos.titre = @photos.filename
    @photos.album_id = params[:id]
    @photos.save
    
    # This returns the thumbnail url for handlers.js to use to display the thumbnail
    render :text => @photos.public_filename(:thumb)
  rescue
    render :text => "Error"
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    render :text => true
  end
  
  def changePhoto
    if !params[:photo][:id].empty? && @photoOld = Photo.find_by_id(params[:photo][:id])
        @photoOld.update_attributes(params[:photo])
    end
    @photoNew = Photo.find(params[:idNew])
    render :partial => 'formPhoto'
  end
  
  def update_photo
    @photo = Photo.find_by_id(params[:photo][:id])
    @photo.update_attributes(params[:photo])
    render :text => true
  end
end

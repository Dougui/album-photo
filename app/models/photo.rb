class Photo < ActiveRecord::Base
  has_attachment :content_type => :image,
                 :storage => :file_system,
                 :size => 500..10.megabytes,
                 :resize_to => '800x800>',
                 :thumbnails => { :medium => '600x600>', :thumb => '100x100>' }

   has_one :album
  
end

# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 5) do

  create_table "albums", :force => true do |t|
    t.string   "titre"
    t.text     "description"
    t.string   "type"
    t.integer  "categorie_id"
    t.integer  "compte_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "amis", :id => false, :force => true do |t|
    t.integer  "compte1"
    t.integer  "compte2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "titre"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commentaires", :force => true do |t|
    t.string   "pseudo"
    t.text     "corps"
    t.integer  "compte_id"
    t.string   "objet_type"
    t.integer  "objet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comptes", :force => true do |t|
    t.string   "pseudo"
    t.string   "mail"
    t.string   "mdp"
    t.text     "description"
    t.string   "avatar"
    t.string   "droits",      :default => "0"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comptes_groupes", :id => false, :force => true do |t|
    t.integer  "compte_id"
    t.integer  "groupe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groupes", :force => true do |t|
    t.string   "titre"
    t.text     "description"
    t.string   "public"
    t.string   "avatar"
    t.integer  "compte_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.string   "titre"
    t.text     "corps"
    t.integer  "etat"
    t.integer  "compte_emetteur"
    t.integer  "compte_recepteur"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news", :force => true do |t|
    t.string   "titre"
    t.text     "corps"
    t.integer  "compte_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.string   "titre"
    t.text     "description"
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visi_album_comptes", :id => false, :force => true do |t|
    t.integer  "compte_id"
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visi_album_groupes", :id => false, :force => true do |t|
    t.integer  "groupe_id"
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

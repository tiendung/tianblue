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

ActiveRecord::Schema.define(:version => 20080930130231) do

  create_table "appearances", :force => true do |t|
    t.integer  "player_id"
    t.integer  "match_id"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "article_images", :force => true do |t|
    t.integer  "size"
    t.string   "content_type"
    t.string   "filename"
    t.integer  "height"
    t.integer  "width"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "posted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "summary"
    t.string   "permalink"
  end

  create_table "cart_items", :force => true do |t|
    t.string   "name"
    t.decimal  "price",      :precision => 8, :scale => 2, :default => 0.0
    t.integer  "quantity"
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sku"
  end

  create_table "carts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "description"
    t.boolean  "featured"
  end

  create_table "category_images", :force => true do |t|
    t.integer  "size"
    t.string   "content_type"
    t.string   "filename"
    t.integer  "height"
    t.integer  "width"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "competitions", :force => true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "name"
    t.string   "competition_type"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "a2"
    t.string   "a3"
    t.integer  "numeric"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer  "appearance_id"
    t.string   "event_type"
    t.integer  "minute"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", :force => true do |t|
    t.string   "name"
    t.decimal  "price",      :precision => 8, :scale => 2, :default => 0.0
    t.integer  "quantity"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sku"
  end

  create_table "matches", :force => true do |t|
    t.integer  "opposition_id"
    t.string   "opposition_kit",   :limit => 50
    t.string   "kit",              :limit => 10
    t.string   "fixture_type",     :limit => 50
    t.datetime "kick_off"
    t.boolean  "home"
    t.integer  "venue_id"
    t.string   "espzen_link",      :limit => 100
    t.integer  "score"
    t.integer  "opposition_score"
    t.text     "report"
    t.text     "report_html"
    t.text     "report_excerpt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "competition_id"
  end

  create_table "mugshots", :force => true do |t|
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news", :force => true do |t|
    t.string   "title",        :limit => 50
    t.string   "permalink",    :limit => 50
    t.text     "body"
    t.text     "body_html"
    t.text     "body_excerpt"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
    t.boolean  "static"
  end

  create_table "newsphotos", :force => true do |t|
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.integer  "news_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oppositions", :force => true do |t|
    t.string   "name"
    t.string   "home_kit"
    t.string   "away_kit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  create_table "orders", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "postcode"
    t.string   "transaction_reference"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "country_id"
    t.boolean  "receive_update",                                                     :default => true
    t.string   "email",                 :limit => 100
    t.string   "phone",                 :limit => 20
    t.integer  "promotion_id"
    t.decimal  "discount_multiplier",                  :precision => 8, :scale => 2, :default => 1.0
  end

  create_table "page_images", :force => true do |t|
    t.integer  "size"
    t.string   "content_type"
    t.string   "filename"
    t.integer  "height"
    t.integer  "width"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.integer  "page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "permalink"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "players", :force => true do |t|
    t.string   "fullname",         :limit => 50
    t.string   "nickname",         :limit => 30
    t.integer  "shirt_number"
    t.text     "description"
    t.text     "description_html"
    t.datetime "joined_at"
    t.string   "position",         :limit => 30
    t.boolean  "goalkeeper"
    t.boolean  "defender"
    t.boolean  "midfield"
    t.boolean  "attacker"
    t.integer  "user_id"
    t.boolean  "management"
    t.boolean  "current_member"
    t.string   "permalink",        :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "left_at"
  end

  create_table "product_images", :force => true do |t|
    t.integer  "size"
    t.string   "content_type"
    t.string   "filename"
    t.integer  "height"
    t.integer  "width"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price",       :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.string   "sku"
  end

  create_table "promotions", :force => true do |t|
    t.string   "promotion_code",      :limit => 50
    t.string   "promotion_name",      :limit => 250
    t.decimal  "discount_percentage",                :precision => 8, :scale => 2, :default => 0.0
    t.date     "valid_from"
    t.date     "valid_until"
    t.boolean  "activate_now",                                                     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "greeting",            :limit => 999
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sizes", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "relative_order"
  end

  create_table "stock_units", :force => true do |t|
    t.integer  "product_id"
    t.integer  "size_id"
    t.integer  "stock",      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sku"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
    t.string   "password_reset_code",       :limit => 40
    t.boolean  "is_admin",                                 :default => false
    t.boolean  "receive_update",                           :default => true
    t.integer  "promotion_id"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "postcode"
    t.string   "googlemap_link"
    t.string   "espzen_link"
    t.string   "streetdirectory_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "longitude"
    t.string   "latitude"
    t.string   "permalink"
    t.text     "directions"
    t.text     "directions_html"
  end

end

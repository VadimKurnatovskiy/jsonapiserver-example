# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170912235438) do

  create_table "authors", force: :cascade do |t|
    t.string "first_name", null: false, collation: "NOCASE"
    t.string "middle_name", collation: "NOCASE"
    t.string "last_name", null: false, collation: "NOCASE"
    t.string "description", collation: "NOCASE"
    t.integer "year_of_birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_name", "last_name"], name: "index_authors_on_first_name_and_last_name", unique: true
  end

  create_table "books", force: :cascade do |t|
    t.integer "publisher_id", null: false
    t.integer "author_id", null: false
    t.string "title", null: false, collation: "NOCASE"
    t.string "description", collation: "NOCASE"
    t.date "publication_date", null: false
    t.float "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_books_on_author_id"
    t.index ["publisher_id"], name: "index_books_on_publisher_id"
    t.index ["title"], name: "index_books_on_title", unique: true
  end

  create_table "checkouts", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "patron_id", null: false
    t.date "checkout_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id", "checkout_date"], name: "index_checkouts_on_book_id_and_checkout_date", unique: true
    t.index ["book_id"], name: "index_checkouts_on_book_id"
    t.index ["patron_id"], name: "index_checkouts_on_patron_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "patron_id", null: false
    t.string "text", null: false, collation: "NOCASE"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_comments_on_book_id"
    t.index ["patron_id", "text"], name: "index_comments_on_patron_id_and_text", unique: true
    t.index ["patron_id"], name: "index_comments_on_patron_id"
  end

  create_table "patrons", force: :cascade do |t|
    t.string "first_name", null: false, collation: "NOCASE"
    t.string "last_name", null: false, collation: "NOCASE"
    t.string "city", null: false, collation: "NOCASE"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_name", "last_name", "city"], name: "index_patrons_on_first_name_and_last_name_and_city", unique: true
  end

  create_table "publishers", force: :cascade do |t|
    t.string "name", null: false, collation: "NOCASE"
    t.string "country", null: false, collation: "NOCASE"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_publishers_on_name", unique: true
  end

end

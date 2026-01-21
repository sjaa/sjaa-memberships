# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2026_01_19_000004) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"
  enable_extension "vector"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "refresh_token"
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "admins_permissions", id: false, force: :cascade do |t|
    t.integer "admin_id", null: false
    t.integer "permission_id", null: false
    t.index ["admin_id", "permission_id"], name: "index_admins_permissions_on_admin_id_and_permission_id"
    t.index ["permission_id", "admin_id"], name: "index_admins_permissions_on_permission_id_and_admin_id"
  end

  create_table "api_keys", force: :cascade do |t|
    t.integer "bearer_id", null: false
    t.string "bearer_type", null: false
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bearer_id", "bearer_type"], name: "index_api_keys_on_bearer_id_and_bearer_type"
    t.index ["token"], name: "index_api_keys_on_token", unique: true
  end

  create_table "app_configs", force: :cascade do |t|
    t.string "key", null: false
    t.text "value"
    t.string "category", null: false
    t.text "description"
    t.boolean "encrypted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_app_configs_on_category"
    t.index ["key"], name: "index_app_configs_on_key", unique: true
  end

  create_table "astrobins", force: :cascade do |t|
    t.string "username"
    t.integer "latest_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "address"
    t.integer "city_id"
    t.integer "state_id"
    t.string "zipcode"
    t.string "phone"
    t.string "email"
    t.boolean "primary"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_contacts_on_person_id"
  end

  create_table "document_archive_articles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "document_id", null: false
    t.string "title", null: false
    t.text "summary"
    t.jsonb "categories", default: []
    t.jsonb "keywords", default: []
    t.integer "page_start"
    t.integer "page_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categories"], name: "index_document_archive_articles_on_categories", using: :gin
    t.index ["document_id"], name: "index_document_archive_articles_on_document_id"
    t.index ["keywords"], name: "index_document_archive_articles_on_keywords", using: :gin
  end

  create_table "document_archive_documents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pdf_file_name"
    t.string "pdf_content_type"
    t.bigint "pdf_file_size"
    t.datetime "pdf_updated_at"
    t.string "txt_file_name"
    t.string "txt_content_type"
    t.bigint "txt_file_size"
    t.datetime "txt_updated_at"
    t.string "markdown_file_name"
    t.string "markdown_content_type"
    t.bigint "markdown_file_size"
    t.datetime "markdown_updated_at"
    t.string "json_file_name"
    t.string "json_content_type"
    t.bigint "json_file_size"
    t.datetime "json_updated_at"
  end

  create_table "document_archive_embeddings", force: :cascade do |t|
    t.uuid "article_id", null: false
    t.vector "vector", limit: 768
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_document_archive_embeddings_on_article_id"
    t.index ["vector"], name: "index_document_archive_embeddings_on_vector", opclass: :vector_cosine_ops, using: :hnsw
  end

  create_table "donation_items", force: :cascade do |t|
    t.integer "donation_id"
    t.integer "equipment_id"
    t.decimal "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "cash", default: false
    t.index ["donation_id"], name: "index_donation_items_on_donation_id"
    t.index ["equipment_id"], name: "index_donation_items_on_equipment_id"
  end

  create_table "donation_phases", force: :cascade do |t|
    t.string "name"
    t.integer "donation_item_id"
    t.integer "person_id"
    t.datetime "date"
    t.index ["donation_item_id"], name: "index_donation_phases_on_donation_item_id"
    t.index ["name"], name: "index_donation_phases_on_name"
    t.index ["person_id"], name: "index_donation_phases_on_person_id"
  end

  create_table "donations", force: :cascade do |t|
    t.string "note"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["person_id"], name: "index_donations_on_person_id"
  end

  create_table "equipment", force: :cascade do |t|
    t.integer "instrument_id"
    t.string "note"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group_id"
    t.index ["group_id"], name: "index_equipment_on_group_id"
    t.index ["instrument_id"], name: "index_equipment_on_instrument_id"
    t.index ["person_id"], name: "index_equipment_on_person_id"
  end

  create_table "equipment_tags", id: false, force: :cascade do |t|
    t.bigint "equipment_id", null: false
    t.bigint "tag_id", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "discord_id"
    t.boolean "joinable", default: false
    t.boolean "members_only", default: false
  end

  create_table "groups_people", id: false, force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "group_id", null: false
    t.index ["group_id"], name: "index_groups_people_on_group_id"
    t.index ["person_id"], name: "index_groups_people_on_person_id"
  end

  create_table "instruments", force: :cascade do |t|
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "model"
    t.index ["kind"], name: "index_instruments_on_kind"
  end

  create_table "interests", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interests_people", id: false, force: :cascade do |t|
    t.integer "interest_id", null: false
    t.integer "person_id", null: false
    t.index ["interest_id", "person_id"], name: "index_interests_people_on_interest_id_and_person_id"
    t.index ["person_id", "interest_id"], name: "index_interests_people_on_person_id_and_interest_id"
  end

  create_table "meetup_events", force: :cascade do |t|
    t.string "meetup_id"
    t.string "url"
    t.string "image_url"
    t.string "title"
    t.datetime "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meetup_id"], name: "index_meetup_events_on_meetup_id", unique: true
  end

  create_table "membership_kinds", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.datetime "start"
    t.integer "term_months"
    t.boolean "ephemeris"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kind_id"
    t.decimal "donation_amount"
    t.integer "order_id"
    t.datetime "end"
    t.string "author"
    t.text "notes"
    t.index ["kind_id"], name: "index_memberships_on_kind_id"
    t.index ["person_id"], name: "index_memberships_on_person_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "message"
    t.integer "person_id"
    t.integer "admin_id"
    t.boolean "unread", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category", default: "system"
    t.string "priority", default: "normal"
    t.string "job_id"
    t.string "job_status"
    t.string "action_url"
    t.index ["admin_id", "unread"], name: "index_notifications_on_admin_id_and_unread"
    t.index ["category"], name: "index_notifications_on_category"
    t.index ["created_at"], name: "index_notifications_on_created_at"
    t.index ["job_id"], name: "index_notifications_on_job_id"
    t.index ["person_id", "unread"], name: "index_notifications_on_person_id_and_unread"
    t.index ["unread"], name: "index_notifications_on_unread"
  end

  create_table "opportunities", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
    t.index ["title"], name: "index_opportunities_on_title"
  end

  create_table "opportunity_skills", force: :cascade do |t|
    t.bigint "opportunity_id", null: false
    t.bigint "skill_id", null: false
    t.integer "skill_level", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["opportunity_id", "skill_id"], name: "index_opportunity_skills_on_opportunity_id_and_skill_id", unique: true
    t.index ["opportunity_id"], name: "index_opportunity_skills_on_opportunity_id"
    t.index ["skill_id"], name: "index_opportunity_skills_on_skill_id"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "price"
    t.string "token"
    t.boolean "paid", default: false
    t.json "membership_params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "payment_method"
    t.index ["token"], name: "index_orders_on_token"
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "astrobin_id"
    t.string "notes"
    t.string "discord_id"
    t.integer "status_id"
    t.integer "referral_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "volunteer", default: false
    t.boolean "mentor", default: false
    t.integer "telescopius_id"
    t.text "mentor_description"
    t.string "mentorship_approval_status"
    t.index ["first_name"], name: "index_people_on_first_name"
    t.index ["last_name"], name: "index_people_on_last_name"
    t.index ["mentorship_approval_status"], name: "index_people_on_mentorship_approval_status"
  end

  create_table "people_permissions", id: false, force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "permission_id", null: false
    t.index ["permission_id", "person_id"], name: "index_people_permissions_on_permission_id_and_person_id"
    t.index ["person_id", "permission_id"], name: "index_people_permissions_on_person_id_and_permission_id"
  end

  create_table "people_skills", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "skill_id", null: false
    t.integer "skill_level", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id", "skill_id"], name: "index_people_skills_on_person_id_and_skill_id", unique: true
    t.index ["person_id"], name: "index_people_skills_on_person_id"
    t.index ["skill_id"], name: "index_people_skills_on_skill_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_permissions_on_name"
  end

  create_table "referrals", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_skills_on_name", unique: true
  end

  create_table "solid_queue_blocked_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.string "concurrency_key", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.index ["concurrency_key", "priority", "job_id"], name: "index_solid_queue_blocked_executions_for_release"
    t.index ["expires_at", "concurrency_key"], name: "index_solid_queue_blocked_executions_for_maintenance"
    t.index ["job_id"], name: "index_solid_queue_blocked_executions_on_job_id", unique: true
  end

  create_table "solid_queue_claimed_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "process_id"
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_claimed_executions_on_job_id", unique: true
    t.index ["process_id", "job_id"], name: "index_solid_queue_claimed_executions_on_process_id_and_job_id"
  end

  create_table "solid_queue_failed_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.text "error"
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_failed_executions_on_job_id", unique: true
  end

  create_table "solid_queue_jobs", force: :cascade do |t|
    t.string "queue_name", null: false
    t.string "class_name", null: false
    t.text "arguments"
    t.integer "priority", default: 0, null: false
    t.string "active_job_id"
    t.datetime "scheduled_at"
    t.datetime "finished_at"
    t.string "concurrency_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active_job_id"], name: "index_solid_queue_jobs_on_active_job_id"
    t.index ["class_name"], name: "index_solid_queue_jobs_on_class_name"
    t.index ["finished_at"], name: "index_solid_queue_jobs_on_finished_at"
    t.index ["queue_name", "finished_at"], name: "index_solid_queue_jobs_for_filtering"
    t.index ["scheduled_at", "finished_at"], name: "index_solid_queue_jobs_for_alerting"
  end

  create_table "solid_queue_pauses", force: :cascade do |t|
    t.string "queue_name", null: false
    t.datetime "created_at", null: false
    t.index ["queue_name"], name: "index_solid_queue_pauses_on_queue_name", unique: true
  end

  create_table "solid_queue_processes", force: :cascade do |t|
    t.string "kind", null: false
    t.datetime "last_heartbeat_at", null: false
    t.bigint "supervisor_id"
    t.integer "pid", null: false
    t.string "hostname"
    t.text "metadata"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.index ["last_heartbeat_at"], name: "index_solid_queue_processes_on_last_heartbeat_at"
    t.index ["name", "supervisor_id"], name: "index_solid_queue_processes_on_name_and_supervisor_id", unique: true
    t.index ["supervisor_id"], name: "index_solid_queue_processes_on_supervisor_id"
  end

  create_table "solid_queue_ready_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_ready_executions_on_job_id", unique: true
    t.index ["priority", "job_id"], name: "index_solid_queue_poll_all"
    t.index ["queue_name", "priority", "job_id"], name: "index_solid_queue_poll_by_queue"
  end

  create_table "solid_queue_recurring_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "task_key", null: false
    t.datetime "run_at", null: false
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_recurring_executions_on_job_id", unique: true
    t.index ["task_key", "run_at"], name: "index_solid_queue_recurring_executions_on_task_key_and_run_at", unique: true
  end

  create_table "solid_queue_recurring_tasks", force: :cascade do |t|
    t.string "key", null: false
    t.string "schedule", null: false
    t.string "command", limit: 2048
    t.string "class_name"
    t.text "arguments"
    t.string "queue_name"
    t.integer "priority", default: 0
    t.boolean "static", default: true, null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_solid_queue_recurring_tasks_on_key", unique: true
    t.index ["static"], name: "index_solid_queue_recurring_tasks_on_static"
  end

  create_table "solid_queue_scheduled_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.datetime "scheduled_at", null: false
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_scheduled_executions_on_job_id", unique: true
    t.index ["scheduled_at", "priority", "job_id"], name: "index_solid_queue_dispatch_all"
  end

  create_table "solid_queue_semaphores", force: :cascade do |t|
    t.string "key", null: false
    t.integer "value", default: 1, null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expires_at"], name: "index_solid_queue_semaphores_on_expires_at"
    t.index ["key", "value"], name: "index_solid_queue_semaphores_on_key_and_value"
    t.index ["key"], name: "index_solid_queue_semaphores_on_key", unique: true
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon"
    t.index ["name"], name: "index_tags_on_name"
  end

  create_table "telescopius", force: :cascade do |t|
    t.string "username"
    t.integer "latest_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "document_archive_articles", "document_archive_documents", column: "document_id"
  add_foreign_key "document_archive_embeddings", "document_archive_articles", column: "article_id"
  add_foreign_key "opportunity_skills", "opportunities"
  add_foreign_key "opportunity_skills", "skills"
  add_foreign_key "people_skills", "people"
  add_foreign_key "people_skills", "skills"
  add_foreign_key "solid_queue_blocked_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_claimed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_failed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_ready_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_recurring_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_scheduled_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
end

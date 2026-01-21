require "test_helper"

class DocumentArchiveIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @admin = Admin.create!(
      email: "archive_admin@sjaa.net",
      password: "password123"
    )
    # Add read permission
    read_permission = Permission.find_or_create_by!(name: "read")
    @admin.permissions << read_permission unless @admin.permissions.include?(read_permission)

    @referral = Referral.find_or_create_by!(name: "internet") do |r|
      r.description = "Web search"
    end

    @person = Person.create!(
      first_name: "Archive",
      last_name: "Tester",
      password: "password123",
      referral: @referral
    )
    Contact.create!(
      email: "archive_tester@example.com",
      person: @person,
      primary: true
    )

    # Create test document archive data
    @document = DocumentArchive::Document.create!(name: "Test Newsletter")
    @article = DocumentArchive::Article.create!(
      document: @document,
      title: "Astronomy Tips",
      summary: "A guide to observing the night sky",
      categories: ["observing", "tips"],
      keywords: ["telescope", "astronomy", "stargazing"],
      page_start: 1,
      page_end: 5
    )
  end

  teardown do
    # Clean up document archive data
    DocumentArchive::Article.delete_all
    DocumentArchive::Document.delete_all
  end

  # === Authentication Tests ===

  test "document archive root requires authentication" do
    get document_archive.root_path
    assert_response :redirect
    # Redirects to main app login (not engine-specific login)
    assert_redirected_to main_app.login_path
  end

  test "document archive api stats requires authentication" do
    get document_archive.api_stats_path
    assert_response :redirect
  end

  test "document archive accessible after admin login" do
    login_as_admin(@admin)
    get document_archive.root_path
    assert_response :success
  end

  test "document archive accessible after person login" do
    login_as_person(@person)
    get document_archive.root_path
    assert_response :success
  end

  # === Static Pages Tests ===

  test "articles page accessible when logged in" do
    login_as_admin(@admin)
    get document_archive.articles_path
    assert_response :success
  end

  test "documents page accessible when logged in" do
    login_as_admin(@admin)
    get document_archive.documents_path
    assert_response :success
  end

  test "document show page accessible when logged in" do
    login_as_admin(@admin)
    get document_archive.document_path(@document.id)
    assert_response :success
  end

  # === API Stats Endpoint ===

  test "api stats returns correct counts when logged in" do
    login_as_admin(@admin)
    get document_archive.api_stats_path
    assert_response :success

    json = JSON.parse(response.body)
    assert_equal DocumentArchive::Document.count, json["documents"]
    assert_equal DocumentArchive::Article.count, json["articles"]
    assert_equal DocumentArchive::Embedding.count, json["embeddings"]
  end

  # === API Documents Endpoint ===

  test "api documents index returns documents list" do
    login_as_admin(@admin)
    get document_archive.api_documents_path
    assert_response :success

    json = JSON.parse(response.body)
    assert json.key?("total")
    assert json.key?("documents")
    assert_equal DocumentArchive::Document.count, json["total"]
  end

  test "api documents show returns document with articles" do
    login_as_admin(@admin)
    get "#{document_archive.api_documents_path}/#{@document.id}"
    assert_response :success

    json = JSON.parse(response.body)
    assert_equal @document.id, json["id"]
    assert_equal @document.name, json["name"]
    assert json.key?("articles")
    assert_equal 1, json["articles"].length
    assert_equal @article.title, json["articles"].first["title"]
  end

  test "api documents show returns 404 for non-existent document" do
    login_as_admin(@admin)
    get "#{document_archive.api_documents_path}/00000000-0000-0000-0000-000000000000"
    assert_response :not_found

    json = JSON.parse(response.body)
    assert_equal "Document not found", json["error"]
  end

  test "api documents index supports pagination" do
    login_as_admin(@admin)
    # Create additional documents
    5.times { |i| DocumentArchive::Document.create!(name: "Doc #{i}") }

    get document_archive.api_documents_path, params: { limit: 2, offset: 0 }
    assert_response :success

    json = JSON.parse(response.body)
    assert_equal 2, json["documents"].length
    assert json["total"] >= 6 # At least our test doc + 5 new ones
  end

  # === API Articles Endpoint ===

  test "api articles index returns articles list" do
    login_as_admin(@admin)
    get document_archive.api_articles_path
    assert_response :success

    json = JSON.parse(response.body)
    assert json.key?("total")
    assert json.key?("articles")
    assert_equal DocumentArchive::Article.count, json["total"]
  end

  test "api articles include document information" do
    login_as_admin(@admin)
    get document_archive.api_articles_path
    assert_response :success

    json = JSON.parse(response.body)
    article_json = json["articles"].find { |a| a["id"] == @article.id }

    assert_not_nil article_json
    assert_equal @document.id, article_json["documentId"]
    assert_equal @document.name, article_json["documentName"]
    assert_equal @article.summary, article_json["summary"]
    assert_equal @article.categories, article_json["categories"]
    assert_equal @article.keywords, article_json["keywords"]
  end

  # === API Search Endpoints ===

  test "search keywords requires query parameter" do
    login_as_admin(@admin)
    post document_archive.api_search_keywords_path
    assert_response :bad_request

    json = JSON.parse(response.body)
    assert_equal "Query parameter is required", json["error"]
  end

  test "search keywords finds articles by keyword" do
    login_as_admin(@admin)
    post document_archive.api_search_keywords_path, params: { query: "telescope" }
    assert_response :success

    json = JSON.parse(response.body)
    assert json.key?("total")
    assert json.key?("results")
    assert json["total"] >= 1

    found_article = json["results"].find { |r| r["id"] == @article.id }
    assert_not_nil found_article
  end

  test "search categories requires query parameter" do
    login_as_admin(@admin)
    post document_archive.api_search_categories_path
    assert_response :bad_request

    json = JSON.parse(response.body)
    assert_equal "Query parameter is required", json["error"]
  end

  test "search categories finds articles by category" do
    login_as_admin(@admin)
    post document_archive.api_search_categories_path, params: { query: "observing" }
    assert_response :success

    json = JSON.parse(response.body)
    assert json.key?("total")
    assert json.key?("results")
    assert json["total"] >= 1

    found_article = json["results"].find { |r| r["id"] == @article.id }
    assert_not_nil found_article
  end

  test "search summary requires query parameter" do
    login_as_admin(@admin)
    post document_archive.api_search_summary_path
    assert_response :bad_request

    json = JSON.parse(response.body)
    assert_equal "Query parameter is required", json["error"]
  end

  test "search summary finds articles by summary text" do
    login_as_admin(@admin)
    post document_archive.api_search_summary_path, params: { query: "night sky" }
    assert_response :success

    json = JSON.parse(response.body)
    assert json.key?("total")
    assert json.key?("results")
    assert json["total"] >= 1

    found_article = json["results"].find { |r| r["id"] == @article.id }
    assert_not_nil found_article
  end

  test "search text requires query parameter" do
    login_as_admin(@admin)
    post document_archive.api_search_text_path
    assert_response :bad_request

    json = JSON.parse(response.body)
    assert_equal "Query parameter is required", json["error"]
  end

  # Note: search_text (vector search) requires GEMINI_API_KEY and embeddings
  # which is better tested in the document-archive gem itself

  # === API Import Endpoint ===

  test "import endpoint requires authentication token" do
    # Import endpoint uses its own token-based auth, not session auth
    post document_archive.api_import_path,
         params: { documents: [] }.to_json,
         headers: { "Content-Type" => "application/json" }

    # Should fail because no IMPORT_API_TOKEN or wrong token
    assert_includes [401, 503], response.status
  end

  # === Person Access Tests ===

  test "person can access document archive pages" do
    login_as_person(@person)

    get document_archive.root_path
    assert_response :success

    get document_archive.articles_path
    assert_response :success

    get document_archive.documents_path
    assert_response :success
  end

  test "person can access document archive api" do
    login_as_person(@person)

    get document_archive.api_stats_path
    assert_response :success

    get document_archive.api_documents_path
    assert_response :success

    get document_archive.api_articles_path
    assert_response :success
  end

  # === Multiple Documents/Articles Tests ===

  test "api returns multiple documents correctly" do
    login_as_admin(@admin)

    # Create additional documents with articles
    doc2 = DocumentArchive::Document.create!(name: "Second Newsletter")
    DocumentArchive::Article.create!(
      document: doc2,
      title: "Equipment Review",
      summary: "Reviewing the latest telescopes",
      categories: ["equipment"],
      keywords: ["telescope", "review"]
    )

    get document_archive.api_documents_path
    assert_response :success

    json = JSON.parse(response.body)
    assert json["total"] >= 2
    assert json["documents"].any? { |d| d["name"] == "Test Newsletter" }
    assert json["documents"].any? { |d| d["name"] == "Second Newsletter" }
  end

  test "search returns results from multiple documents" do
    login_as_admin(@admin)

    # Create another document with matching keyword
    doc2 = DocumentArchive::Document.create!(name: "Equipment Guide")
    DocumentArchive::Article.create!(
      document: doc2,
      title: "Choosing a Telescope",
      summary: "How to choose your first telescope",
      categories: ["equipment", "beginner"],
      keywords: ["telescope", "buying guide"]
    )

    post document_archive.api_search_keywords_path, params: { query: "telescope" }
    assert_response :success

    json = JSON.parse(response.body)
    assert json["total"] >= 2 # Both articles have "telescope" keyword
  end

  private

  def document_archive
    DocumentArchive::Engine.routes.url_helpers
  end

  def main_app
    Rails.application.routes.url_helpers
  end
end

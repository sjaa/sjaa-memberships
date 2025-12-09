# app/helpers/markdown_helper.rb
module MarkdownHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(
      filter_html: true, # prevent raw HTML injection
      hard_wrap: true
    )
    markdown = Redcarpet::Markdown.new(
      renderer,
      autolink: true,
      tables: true,
      fenced_code_blocks: true
    )
    markdown.render(text).html_safe
  end
end

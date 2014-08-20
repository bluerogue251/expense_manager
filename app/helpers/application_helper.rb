module ApplicationHelper
  def markdown(text)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true
    }
    renderer = Redcarpet::Render::HTML
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end
end

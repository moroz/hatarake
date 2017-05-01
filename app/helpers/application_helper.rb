module ApplicationHelper
  def safe_textilize(text)
    renderer = RedCloth.new(text)
    renderer.sanitize_html = true
    renderer.to_html
  end
end

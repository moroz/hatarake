module ApplicationHelper
  def safe_textilize(text)
    renderer = RedCloth.new(text)
    renderer.sanitize_html = true
    renderer.to_html
  end

  def locale_flag(lang)
    image_tag "/flag-#{lang}.svg", class: 'locale_flag'
  end

  def locale_link(lang)
    link_to locale_flag(lang), lang: lang
  end
end

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

  def body_tag(&block)
    options = {
      class: "#{controller_name} #{action_name}"
    }
    options = options.merge({'data-no-turbolink' => true}) if @disable_turbolinks
    content_tag :body, options do
      concat capture(&block)
    end
  end
end

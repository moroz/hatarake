module ApplicationHelper
  def safe_textilize(text)
    renderer = RedCloth.new(text)
    renderer.sanitize_html = true
    renderer.to_html
  end

  def safe_markdown(text)
    options = {
      filter_html:     true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  def error_messages_for(object)
    content_tag :div, class: 'error_explanation', id: 'error_explanation' do
      render partial: 'shared/errors', locals: { object: object }
    end
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

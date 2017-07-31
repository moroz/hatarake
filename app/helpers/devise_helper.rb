module DeviseHelper
  def devise_error_messages!
    return content_tag :div, nil, class: 'error_explanation', id: 'error_explanation' unless devise_error_messages?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div class="error_explanation" id="error_explanation">
      <div class="callout alert text-left">
        #{sentence}
        <ul>#{messages}</ul>
      </div>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

end

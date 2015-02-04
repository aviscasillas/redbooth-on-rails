module ApplicationHelper
  def title(title)
    content_tag(:h2) { title }
  end

  def default_description
    content_tag(:em, class: 'text-muted') { 'No description available' }
  end

  def description(description)
    text = description.present? ? description : default_description
    text.html_safe
  end

  def created_on(datetime)
    "Created on #{Time.at(datetime).strftime('%c')}"
  end

  def glyphicon(icon_name)
    content_tag(:span, class: "glyphicon glyphicon-#{icon_name}") { '' }
  end

  def link_to_login(options = {})
    text = "#{glyphicon('user')} Login with Redbooth".html_safe
    link_to(text, '/auth/redbooth', options)
  end

  def link_to_logout
    text =
      "Logout <b>#{current_user.name}</b> #{glyphicon('log-out')}".html_safe
    link_to(text, sign_out_path)
  end
end

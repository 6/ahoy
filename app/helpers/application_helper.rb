module ApplicationHelper
  def body_classes
    name = controller_name
    [
      "#{name}-#{action_name}",
      "request-path#{request.path.gsub("/", "-")}",
    ].join(" ").gsub("_", "-")
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def active_if_current(path)
    request.path == path ? ' active ' : ''
  end

  def active_if_any_current(paths)
    any_active = paths.any? do |path|
      path = send(path)  if path.is_a?(String)
      path == request.path
    end
    any_active ? ' active ' : ''
  end

  def pretty_time(time)
    return  unless time.present?
    (time.strftime("%-m/%-d/%Y") + "<span class='hidden-mobile'> (#{time_ago_in_words(time)} ago)</span>").html_safe
  end
end

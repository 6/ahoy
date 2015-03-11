module ApplicationHelper
  def body_classes
    name = controller_name
    [
      "#{name}-#{action_name}",
      "request-path#{request.path.gsub("/", "-")}",
    ].join(" ").gsub("_", "-")
  end

  def active_if_current(path)
    request.path == path ? ' active ' : ''
  end
end

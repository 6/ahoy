module ApplicationHelper
  def body_classes
    name = controller_name
    [
      "#{name}-#{action_name}",
      "request-path#{request.path.gsub("/", "-")}",
    ].join(" ").gsub("_", "-")
  end
end

module ApplicationHelper
  def include_template(template_name)
    content_tag :script, type: 'text/ng-template', id: "#{template_name}.html" do
      render template_name
    end
  end
end

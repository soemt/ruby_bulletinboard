module ApplicationHelper
  def current_class?(test_path)
    return 'active:bg-gray-900 text-white' if request.path == test_path
    ''
  end

  def active_class(link_path)
    current_page?(link_path) ? "" : "bg-gray-900 text-white"
  end

  def current?(key, path)
    "#{key}" if current_page? path
    # We use string interpolation "#{key}" here to access the CSS classes we are going to create.
  end
end

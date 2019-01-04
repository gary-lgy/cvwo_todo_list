module ApplicationHelper
  # append a new query string to a url
  def append_query_string_to_url(url, name, value)
    if url.include? '?'
      "#{url}&#{name}=#{value}"
    else
      "#{url}?#{name}=#{value}"
    end
  end

end

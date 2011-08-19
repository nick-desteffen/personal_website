module PostsHelper
  
  def gravatar_image(gravatar_hash, options={})
    return if gravatar_hash.blank?
    size = options[:size] || 75
    alt = options[:alt] || ""
    title = options[:title] || ""
    image_tag("http://www.gravatar.com/avatar/#{gravatar_hash}?size=#{size}", :alt => alt, :title => title)
  end
  
  def comment_name(comment)
    if comment.url.present?
      link_to comment.name, comment.url, :target => "_blank"
    else
      comment.name
    end
  end
  
end

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
  
  def format_comment(comment)
    MARKDOWN_RENDERER.render(comment).html_safe
  end
  
  def admin_comment_links(comment)
    return unless current_user
    links = link_to "Flag Spam", flag_spam_path(comment), :remote => true, :method => :post, :class => "spam_link", :confirm => "Are you sure?"
    links += link_to "Edit", edit_comment_path(comment.post, comment), :class => "spam_link"
    links
  end
  
end

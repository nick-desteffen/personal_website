module PostsHelper

  def gravatar_image(gravatar_hash, options={})
    return if gravatar_hash.blank?
    size  = options.fetch(:size, 75)
    alt   = options.fetch(:alt, "")
    title = options.fetch(:title, "")
    image_tag("http://www.gravatar.com/avatar/#{gravatar_hash}?size=#{size}", alt: alt, title: title)
  end

  def comment_name(comment)
    if comment.url.present?
      link_to comment.name, comment.url, :target => "_blank"
    else
      comment.name
    end
  end

  def format_comment(comment)
    return if comment.blank?
    markdown_renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true)
    markdown_renderer.render(comment).html_safe
  end

  def admin_comment_links(comment)
    return unless current_user
    return if comment.new_record?
    links = link_to "Flag Spam", flag_spam_path(comment.post, comment), remote: true, method: :post, class: "admin_link", data: {confirm: "Are you sure?"}
    links += link_to "Edit", edit_comment_path(comment.post, comment), class: "admin_link"
    links += link_to "Destroy", destroy_comment_path(comment.post, comment), class: "admin_link", remote: true, method: :delete, data: {confirm: "Are you sure?"}
    links
  end

  def teaser(post)
    truncate(strip_tags(post.body).gsub("&ndash;", " - "), length: 300, omission: '...')
  end

end

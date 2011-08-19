atom_feed do |feed|   
  feed.title("Nick DeSteffen")
  feed.updated(@posts.first.created_at)
  @posts.each do |post|
    feed.entry(post, :url => blog_post_url(post)) do |entry|
      entry.title(post.title)
      entry.content(post.body, :type => 'html')
      entry.author { |author| author.name("Nick DeSteffen")}
    end
  end
end
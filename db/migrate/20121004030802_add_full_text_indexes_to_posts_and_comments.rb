class AddFullTextIndexesToPostsAndComments < ActiveRecord::Migration

  def up
    execute "create index posts_text_search_body on posts using gin(to_tsvector('english', body))"
    execute "create index posts_text_search_title on posts using gin(to_tsvector('english', title))"
    execute "create index comments_text_search_body on comments using gin(to_tsvector('english', body))"
    execute "create index comments_text_search_name on comments using gin(to_tsvector('english', name))"
  end

  def down
    execute "drop index posts_text_search_body"
    execute "drop index posts_text_search_title"
    execute "drop index comments_text_search_body"
    execute "drop index comments_text_search_name"
  end

end

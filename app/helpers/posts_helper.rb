module PostsHelper

  HeadlineSize = 40

  def headline(post)
    post.content.truncate(HeadlineSize)
  end
end

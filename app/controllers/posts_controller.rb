require_relative '../models/post'
require_relative '../views/posts_view'

class
   PostsController
  def initialize
    @view = PostsView.new
  end

  ################################################################
  # BEWARE: you MUST NOT use the global variable DB in this file #
  ################################################################

  def index
    posts = Post.all
    @view.list(posts)
  end

  def create
    index
    title = @view.ask_user_for("title")
    url = @view.ask_user_for("url")
    new_post = Post.new(title: title, url: url)
    new_post.save
    index
  end

  def update
    index
    id = @view.ask_user_for("id for the post you want to update")
    find_id = Post.find(id)
    title = @view.ask_user_for("updated title")
    url = @view.ask_user_for("updated url")
    updated_post = Post.new(id: id, title: title, url: url)
    updated_post.save
    index
  end

  def destroy
    index
    id = @view.ask_user_for("id for the post you want to delete")
    post = Post.find(id)
    post.destroy
    index
  end

  def upvote
    index
    id = @view.ask_user_for("id")
    post = Post.find(id)
    post.votes += 1
    post.save
    index
  end
end

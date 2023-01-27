class PostsView
  # TODO: implement methods called by the PostsController
  def list(posts)
    posts.each do |post|
      puts "#{post.id}. - #{post.title} - #{post.url} - #{post.votes}"
    end
  end

  def ask_user_for(stuff)
    puts "What is the #{stuff}?"
    print "> "
    gets.chomp
  end
end

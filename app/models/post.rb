class Post
  attr_reader :id
  attr_accessor :title, :url, :votes

  def initialize(attributes = {})
    @id = attributes[:id] || attributes['id']
    @title = attributes[:title] || attributes['title']
    @url = attributes[:url] || attributes['url']
    @votes = attributes[:votes] || attributes['votes'] || 0
  end

  def self.find(id)
    DB.results_as_hash = true
    query = <<~SQL
      SELECT * FROM posts
      WHERE id = ?
    SQL
    result = DB.execute(query, id).first
    Post.new(id: result['id'], title: result['title'], url: result['url'], votes: result['votes']) if result
  end

  def self.all
    DB.results_as_hash = true
    results = DB.execute('SELECT * FROM posts')
    results.map do |post_hash|
      Post.new(post_hash)
    end
  end

  def destroy
    query = <<~SQL
      DELETE FROM posts
      WHERE id = #{id}
    SQL
    DB.execute(query)
  end

  def save
    if @id.nil?
      DB.execute('INSERT INTO posts (url, votes, title) VALUES (?, ?, ?)', @url, @votes, @title)
      @id = DB.last_insert_row_id
    else
      DB.execute('UPDATE posts SET title = ?, url = ?, votes = ? WHERE id = ?', @title, @url, @votes, @id)
    end
  end
end

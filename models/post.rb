class Books

  attr_accessor :id, :title, :author, :description

  def self.open_connection
    conn = PG.connect(dbname: "blog", user: "postgres", password: "Acad3my1")
  end

  #retrieves data from our database
  def self.all
    conn = self.open_connection
    sql = "SELECT * FROM books ORDER BY id"
    results = conn.exec(sql)

    all_the_books = results.map do |tuple|
      self.hydrate tuple #turns data into hash
    end
    return all_the_books

  end

  #selects data from the table with a specific id
  def self.find id
    conn = self.open_connection
    sql = "SELECT * FROM books WHERE id = #{id}"
    result = conn.exec(sql)

    books = self.hydrate result[0]
    return books

  end


  #info in the database cannot be displayed on the screen, so use hydrate to convert to an hash
  def self.hydrate books_data
    books = Books.new
    books.id = books_data['id']
    books.title = books_data['title']
    books.author = books_data['author']
    books.description = books_data['description']
    return books
  end


  def save
      conn = Books.open_connection
      if (!self.id)
        sql = "INSERT INTO books (title, author, description) VALUES ('#{self.title}', '#{self.author}', '#{self.description}')"
      else
        sql = "UPDATE books SET title = '#{self.title}', author = '#{self.author}', description = '#{self.description}' WHERE id = '#{self.id}'"
      end
      conn.exec(sql)
    end


  def self.destroy id
    conn = Books.open_connection
    sql = "DELETE FROM books WHERE id = '#{id}'"
    conn.exec(sql)
  end

end

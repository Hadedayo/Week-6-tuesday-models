class PostController < Sinatra::Base

  set :root, File.join(File.dirname(__FILE__), "..")

  set :view, Proc.new { File.join(root, "views") }


  configure:development do
    register Sinatra::Reloader
  end

  get "/" do
    @title_of_page = "Books to Read"
    @myBooks = Books.all
    erb :'posts/index'
  end

  get "/:id_from_books" do
    id = params[:id_from_books].to_i
    @books = Books.find id
    erb :'posts/show'
  end

  get '/new' do
    @books = Books.new
    erb :'posts/new'
  end

  get "/:id_from_url/edit" do
    id = params[:id_from_url].to_i
    @books = Books.find id
    erb :'posts/edit'
  end

  #put updates after editing the form
  put "/:id" do
    id = params[:id].to_i
    books = Books.find id
    books.title = params[:title]
    books.author = params[:author]
    books.description = params[:description]
    books.save
    redirect '/'
  end

  # When you press save in new book section
    post "/" do
      post = Books.new
      books.title = params[:title]
      books.author = params[:author]
      books.description = params[:description]
      books.save
      redirect "/"
    end

    delete "/:id" do
      id = params[:id].to_i
      Books.destroy id
      redirect '/'
    end










end

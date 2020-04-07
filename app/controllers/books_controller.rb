class BooksController < ApplicationController
    before_action :authenticate_user!
    before_action :correct_user, only: [:edit, :update]
	def new
		@book = Book.new
    end
    def create
    	@book = Book.new(book_params)
	    @book.user_id = current_user.id
	    if @book.save
           flash[:notice] = "Book was successfully created"
	       redirect_to book_path(@book)
        else
            @books = Book.all
            @user = current_user
            render action: :index
        end
    end
    def index
    	@book = Book.new
    	@books = Book.all
        @user = current_user
    end
    def show
        @books = Book.all
    	@book = Book.find(params[:id])
        @user = @book.user
    end
    def edit
        @book = Book.find(params[:id])
    end
    def destroy
		book = Book.find(params[:id])
		book.delete
		redirect_to books_path
	end

    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
          flash[:notice] = "Book was successfully updated"
          redirect_to book_path(@book)
        else
          render action: :edit
        end
    end

    private
    def book_params
        params.require(:book).permit(:title, :body)
    end
    def correct_user
        @book = Book.find(params[:id])
        @user = @book.user
        if current_user != @user
          redirect_to books_path
        end
    end
end

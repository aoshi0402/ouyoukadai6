class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :index, :show, :edit]

  def index
    @book = Book.new
    @books = Book.all
  end

  def show
    @book_show = Book.find(params[:id])
    @user = @book_show.user
    @book = Book.new
    @book_comment = BookComment.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: 'Book was successfully created'
    else
      @books = Book.all
      render :index
    end
  end

  def new
  end

  def edit
    @book = Book.find(params[:id])
    if current_user.id == @book.user_id
    else
      redirect_to books_path
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path, notice: 'Book was successfully destroy'
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'Book was successfully created'
    else
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end

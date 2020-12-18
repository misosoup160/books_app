# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @books = Book.order(:id).page(params[:page]).per(10)
  end

  def show; end

  def new
    @book = Book.new
  end

  def edit; end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book
      flash[:notice] = t 'notice.create', model: Book.model_name.human
    else
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book
      flash[:notice] = t 'notice.update', model: Book.model_name.human
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url
    flash[:notice] = t 'notice.destroy', model: Book.model_name.human
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :memo, :author, :picture)
  end
end

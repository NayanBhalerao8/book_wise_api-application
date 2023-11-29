module Api
  module V1
    class BooksController < ApplicationController
      protect_from_forgery with: :null_session 
      def index
        render json: Book.all
      end

      def create 
        protect_from_forgery = false
        book = Book.new(title: params[:title], author: params[:author])
        if book.save 
          render json: book, status: :created
        else
          render json: book.errors, status: :unprocessable_entity
        end
      end

      def destroy 
        Book.find(params[:id]).destroy!
        head :no_content
      end
      private 
      def book_params 
        params.require(:book).permit(:title, :author)
      end

      
    end
  end
end


module Api
  module V1
    class BooksController < ApplicationController
      protect_from_forgery with: :null_session 
      def index
        books = Book.all.offset(params[:offset]).limit(:limit)
        # render json: Book.all
        # instead of loading all the data, we can choose and define the needed data using a representetor
        render json: BooksRepresenter.new(books).as_json
      end

      def create 
        author = Author.create!(author_params)
        book = Book.new(book_params.merge(author_id: author.id))
        if book.save 
          render json: BookRepresenter.new(book).as_json, status: :created
        else
          render json: book.errors, status: :unprocessable_entity
        end
      end

      def destroy 
        Book.find(params[:id]).destroy!
        head :no_content
      end
      
      private 
      def author_params 
        params.require(:author).permit(:first_name,:last_name,:age)
      end
      def book_params 
        params.require(:book).permit(:title)
      end
    end
  end
end


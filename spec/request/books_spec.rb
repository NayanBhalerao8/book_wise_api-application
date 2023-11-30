require 'rails_helper'

describe 'books api', type: :request do 
    describe 'GET books' do 
        it 'should return all books' do 
            FactoryBot.create(:book, title: '1987', author: "nayan bhalerao")
            FactoryBot.create(:book, title: '2000', author: "nayan 6")
            get '/api/v1/books'
            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(2)
        end
    end

    describe 'POST /books', type: :request do 
        it 'should create a new book' do
          expect {
            post '/api/v1/books', params: { book: { title: 'the title', author: 'the author' } }
          }.to change {Book.count}.by(1)
          expect(response).to have_http_status(:created)
        end
    end    

   describe 'DELETE books/:id', type: :request do 
    it 'should delete a book' do 
      FactoryBot.create(:book, title: '1987', author: "nayan bhalerao")
      delete '/api/v1/books/1'
      expect(response).to have_http_status(:no_content)
    end
   end
end
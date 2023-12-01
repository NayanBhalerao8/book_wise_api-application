require 'rails_helper'

describe 'books api', type: :request do 
  # writing them here so they will be available in all describe blocks
  let(:first_author) {FactoryBot.create(:author, first_name: 'John', last_name: 'donut',age:55)}
  let(:second_author) {FactoryBot.create(:author, first_name: 'cat', last_name: 'papper',age:53)}
    describe 'GET books' do 
          before do 
            FactoryBot.create(:book, title: '1987', author: first_author)
            FactoryBot.create(:book, title: '2000', author: second_author)
          end

          it 'should return all books' do 
            get '/api/v1/books'
            expect(response).to have_http_status(:success)
            expect(response_body.size).to eq(2)
            # for new API response structure 
            expect(response_body).to eq (
              [
                {"author_age"=>55, 
                  "author_name"=>"John donut", 
                  "id"=>1, 
                  "title"=>"1987"}, 
                {"author_age"=>53, 
                  "author_name"=>"cat papper", 
                  "id"=>2, 
                  "title"=>"2000"}
                ]
              )
        end
    end

    describe 'POST /books', type: :request do 
        it 'should create a new book' do
          expect {
            post '/api/v1/books',
            params: { 
                book: { title: 'nayan biography'},
                author: {first_name: 'the author',last_name: 'bhalerao',age:24 } 
              }
          }.to change {Book.count}.by(1)
          expect(response).to have_http_status(:created)
          expect(Author.count).to eq(1)
          expect(response_body).to eq ({
            'id' => 1,
            'title' => 'nayan biography',
            'author_name' => 'the author bhalerao',
            'author_age' => 24
          })
        end
    end    

   describe 'DELETE books/:id', type: :request do 
      let!(:book) { FactoryBot.create(:book, title: '1987', author: first_author)}
      it 'should delete a book' do 
        delete '/api/v1/books/1'
        expect(response).to have_http_status(:no_content)
      end
   end
end
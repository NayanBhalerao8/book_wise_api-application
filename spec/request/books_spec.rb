require 'rails_helper'

describe 'books api', type: :request do 
    it 'should return all books' do 
        get '/api/v1/books'
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(2)
    end
end
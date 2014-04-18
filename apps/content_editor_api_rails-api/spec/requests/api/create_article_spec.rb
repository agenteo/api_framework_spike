require 'spec_helper'

describe 'POST /api/v1/article' do

  let(:article_params) { { title: 'Something about weddings', body: 'Here it starts...' } }

  context 'with all mandatory fields filled in' do
    it "should return 200" do
      post '/api/v1/articles', article: article_params
      expect(response.status).to eq(200)
    end

    it 'should persist the article' do
      expect {
        post '/api/v1/articles', article: article_params
      }.to change{ Article.count }.from(0).to(1)
    end
  end

  context 'with missing mandatory fields' do
    let(:incomplete_article_params) { article_params.merge(title: '') }

    it "should return 400" do
      post '/api/v1/articles', article: incomplete_article_params
      expect(response.status).to eq(400)
    end

    it 'should not persist the article' do
      expect {
        post '/api/v1/articles', article: incomplete_article_params
      }.to_not change{ Article.count }
    end

    it 'should return validation messages' do
      post '/api/v1/articles', article: incomplete_article_params
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['article']['errors']['title']).to_not be_nil
    end

  end


end

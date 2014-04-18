module Api
  module V1

    class ArticlesController < ApplicationController
      skip_before_filter :verify_authenticity_token

      # GET /api/v1/articles/:id
      def show
        render json: { title: 'Test title', body: 'Test body' }
      end

      # POST /api/v1/articles
      def create
        article = Article.new(article_params)
        if article.save
          render json: article.to_json
        else
          article_errors = article.errors.to_json
          render json: { message: 'There was a problem.',
                         article: { errors: article_errors } },
                 status: 400
        end
      end

      # PUT /api/v1/articles
      def update
      end


      private

        def article_params
          params.require(:article).permit(:title, :body)
        end

    end

  end
end

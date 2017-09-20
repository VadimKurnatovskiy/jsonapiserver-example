module Api
  module V1
    class BooksController < ApplicationController

      def index
        builder = JsonApiServer::Builder.new(request, Book.all)
         .add_pagination(pagination_options)
         .add_filter(filter_options)
         .add_include(include_options)
         .add_sort(sort_options)
         .add_fields

        serializer = ::V1::BooksSerializer.from_builder(builder)
        render json: serializer.to_json, status: :ok
      end

      def show
        serializer = book_serializer_for(Book.find(params[:id]))
        render json: serializer.to_json, status: :ok
      end

      def create
        form = ::V1::AddBook.new(book_params, author_params, publisher_params)
        if form.save
          serializer = book_serializer_for(form.book)
          render json: serializer.to_json, status: :created
        else
          render_422(form.book)
        end
      end

      protected

      def book_serializer_for(book)
        builder = JsonApiServer::Builder.new(request, book)
         .add_include(include_options)
         .add_fields
       ::V1::BookSerializer.from_builder(builder)
      end

      def pagination_options
        {
          default_per_page: 10,
          max_per_page: 60
        }
      end

      def sort_options
        {
           permitted: [
             :title,
             :author_id,
             { published: { col_name: :publication_date} }
           ],
           default: { id: :desc }
        }
      end

      def filter_options
        [
           { id: { type: 'Integer' } },
           { author_id: { type: 'Integer' } },
           { title: { wildcard: :both } },
           { description: { wildcard: :both } },
           { published: { col_name: :publication_date, type: 'Date' } },
           { published1: { col_name: :publication_date, type: 'Date' } },
           { author: { builder: :model_query, method: :by_author_name } }
        ]
      end

      def include_options
        [
          'book.author',
          'book.publisher',
          'book.comments',
          'book.checkouts',
          'comment.patron',
          'checkout.patron'
        ]
      end

      def book_params
        params.require(:data)
              .require(:attributes)
              .permit(:publisher_id, :author_id, :title, :description, :publication_date, :price)
      end

      def author_params
        params.require(:data)
              .require(:relationships)
              .require(:author)
              .require(:data)
              .require(:attributes)
              .permit(:first_name, :middle_name, :last_name, :description, :year_of_birth)
      end

      def publisher_params
        params.require(:data)
              .require(:relationships)
              .require(:publisher)
              .require(:data)
              .require(:attributes)
              .permit(:name, :country)
      end

    end
  end
end

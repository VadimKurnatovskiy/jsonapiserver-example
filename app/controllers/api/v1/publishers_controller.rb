module Api
  module V1
    class PublishersController < ApplicationController

      def index
        builder = SimpleJsonApi::Builder.new(request, Publisher.all)
         .add_pagination(pagination_options)
         .add_filter(filter_options)
         .add_include(include_options)
         .add_sort(sort_options)
         .add_fields

       serializer = ::V1::PublishersSerializer.from_builder(builder)
       render json: serializer.to_json, status: :ok
      end

      def show
        builder = SimpleJsonApi::Builder.new(request, Publisher.find(params[:id]))
         .add_include(include_options)
         .add_fields

       serializer = ::V1::PublisherSerializer.from_builder(builder)
       render json: serializer.to_json, status: :ok
      end

      protected

      def pagination_options
        { default_per_page: 10, max_per_page: 60 }
      end

      def sort_options
        {
          permitted: [
            :name,
            :country
          ],
          default: { id: :desc }
        }
      end

      def filter_options
        [
          { id: { type: 'Integer' } },
          { country: { wildcard: :right } },
          { name: { wildcard: :both } }
        ]
      end

      def include_options
        [
          {'publisher.books': -> { includes(:books) }},
          {'publisher.books.include': -> { includes(:books) }},
          {'book.author': -> { includes(books: :author)}},
          {'book.comments': -> { includes(books: :comments) }}
        ]
      end
    end
  end
end

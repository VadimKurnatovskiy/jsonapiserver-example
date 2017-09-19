module V1
  class AddBook

    attr_reader :book

    def initialize(book_params, author_params, publisher_params)
      @book = Book.new(book_params)
      @author = Author.new(author_params) if author_params.present?
      @publisher = Publisher.new(publisher_params) if publisher_params.present?
    end

    def save
      @book.author = @author if @author
      @book.publisher = @publisher if @publisher
      @book.save || bubble_errors
    rescue ActiveRecord::NotNullViolation => e
      bubble_errors
    end

    protected

    def bubble_errors
      [@author, @publisher].each do |record|
        if record.respond_to?(:errors) && record.errors.present?
          @book.errors.add("#{record.class.name}:", record.errors.full_messages.first)
        end
      end

      false
    end
  end
end

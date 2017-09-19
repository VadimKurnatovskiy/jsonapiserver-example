class Book < ApplicationRecord
  belongs_to :publisher, required: true
  belongs_to :author, required: true
  has_many :comments
  has_many :checkouts

  validates :title, :price, :publication_date, presence: true
  validates :price, numericality: { greater_than: 0 }

  def self.by_author_name(name)
    return Book.none unless name.present?
    value = "%#{name}%"
    Book.joins(:author)
        .where("authors.first_name LIKE ? OR authors.last_name LIKE ?", value, value)
  end

  def publication_date=(value)
    date = value.respond_to?(:ctime) ? value : (Date.parse(value) rescue nil)
    super(date)
  end

  # Patrons are eager loaded even if not used. Assuming that if a comment
  # is fetched, the author/patron will be too as they are usually displayed
  # together. So comments + authors are cached.
  def cached_comments(version, count)
    key = "#{version}-book#{id}-comments#{count}-#{cache_key}"
    Rails.cache.fetch(key, expires_in: 25.minutes) do
      comments.includes(:patron).order(id: :desc).limit(count).to_a
    end
  end

  # Eagerloads patron similar to comments. Ordered by checkout date in
  # descending order.
  def cached_checkouts(version, count)
    key = "#{version}-book#{id}-checkouts#{count}-#{cache_key}"
    Rails.cache.fetch(key, expires_in: 25.minutes) do
      checkouts.includes(:patron).order(checkout_date: :desc).limit(count).to_a
    end
  end
end

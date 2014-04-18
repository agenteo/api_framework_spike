class Article
  include Mongoid::Document
  field :title, type: String
  field :body, type: String

  validates :title, :body, presence: true
end

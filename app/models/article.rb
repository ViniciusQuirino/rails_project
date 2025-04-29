class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 } # campo title obrigatório
  validates :body, presence: true, length: { minimum: 10 } # campo body obrigatório
end

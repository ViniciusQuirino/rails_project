class Article < ApplicationRecord
  belongs_to :category # um artigo pertence a uma categoria
  belongs_to :user # um artigo pertence a um usuario

  validates :title, presence: true, length: { minimum: 5 } # campo title obrigatório
  validates :body, presence: true, length: { minimum: 10 } # campo body obrigatório

  paginates_per 2 # quantidade de registro por pagina

  scope :desc_order, -> { order(created_at: :desc) }
  scope :without_highlights, ->(ids) { where("id NOT IN(#{ids})") if ids.present? }
  scope :filter_by_category, ->(category) { where(category_id: category.id) if category.present? }
end

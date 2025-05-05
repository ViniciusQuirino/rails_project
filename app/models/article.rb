class Article < ApplicationRecord
  belongs_to :category # um artigo pertence a uma categoria
  belongs_to :user # um artigo pertence a um usuario

  has_many :comments, dependent: :destroy # um artigo tem muitos comentarios
  
  validates :title, presence: true, length: { minimum: 5 } # campo title obrigatório
  validates :body, presence: true, length: { minimum: 10 } # campo body obrigatório

  paginates_per 10 # quantidade de registro por pagina

  scope :desc_order, -> { order(created_at: :desc) }
  scope :without_highlights, ->(ids) { where("id NOT IN(#{ids})") if ids.present? }
  scope :filter_by_category, ->(category) { where(category_id: category.id) if category.present? }
  scope :filter_by_archive, lambda { |month_year|
    if month_year
      date = Date.strptime(month_year, '%B %Y')
      where created_at: date.beginning_of_month..date.end_of_month.next_day
      # beginning_of_month - inicio do mes até o final do mes end_of_month
    end
  }
end

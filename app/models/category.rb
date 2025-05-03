class Category < ApplicationRecord
  has_many :articles, dependent: :restrict_with_error # uma categoria tem muitos artigos
  
  validates :name, presence: true, length: { minimum: 3 },
                   uniqueness: { case_sensitive: false } # campo title obrigatório e tamanho minimo de 3

  scope :sorted, -> { order(:name) }
end

class Product < ApplicationRecord
    # Aquí debes definir las relaciones con otras tablas si las tienes, por ejemplo:
    # has_many :orders
    # belongs_to :category
  
    validates :name, presence: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :description, presence: true
  
    # Aquí puedes definir métodos personalizados si los necesitas
    def formatted_price
      "$#{price}"
    end
  end
  
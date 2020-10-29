################################################################################
# Model:  Product
#
# Purpose: Demo Product entity
#
# Product attributes:
#   name            - name:         string,  not NULL, unique
#   title           - title:        string,  not NULL
#   sku             - sku:          string,  not NULL
#   price           - price:        decimal, not NULL
#   description     - description:  text
#   status          - status:       enum { active (0) | archived (1) }
#
#  29.10.2020 ZT
################################################################################
class Product < ApplicationRecord
  # has_rich_text :content
  enum status: %w(active archived)
  
  validates :name,  presence: true, uniqueness: true
  validates :title, presence: true
  validates :sku,   presence: true, uniqueness: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
end

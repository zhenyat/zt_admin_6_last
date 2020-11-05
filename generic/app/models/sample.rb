###########################################################
# Model:  Sample
#
# Purpose:  Demo Entity
#
# Attributes
#   name      - string
#   title     - string
#   price     - decimal, default: 0.0
#   quantity  - integer, default: 0
#   status    - enum { active (0) | archived (1) }
#
#   content     - Active Text attachement
#   cover_image - Active Storage attachement
#   images      - Active Storage attachements
#
#   05.11.2020  ZT
###########################################################
class Sample < ApplicationRecord
  has_rich_text     :content
  has_one_attached  :cover_image, dependent: :destroy
  has_many_attached :images,      dependent: :destroy
  before_destroy    :remove_all_images, prepend: true

  attr_accessor :remove_cover_image

  enum status: %w(active archived)
  
  validates :name,     presence: true, uniqueness: true
  validates :title,    presence: true
  validates :price,    presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :quantity, presence: true, numericality: {greater_than_or_equal_to: 0}

  private

  # Removes all images (if any) for destroyed instance 
  def remove_all_images
    self.cover_image.purge                 if self.cover_image.attached?
    self.images.each {|image| image.purge} if self.images.attached?
  end
end

################################################################################
#   If gem 'ancestry' is applied
#
#   Examples:
#     women = Category.create(name: 'Women')
#     women_bags = Category.create(name: 'Bags', parent: women)
#     women_clothes = Category.create(name: 'Clothes', parent: women)
#   26.12.2020  ZT
################################################################################
module Heritable
  extend ActiveSupport::Concern

  included do
    has_ancestry

    before_validation do
      self.ancestry = nil if self.ancestry.blank?
    end
  end
end
class Spot < ApplicationRecord

  def self.search(query)
    where("LOWER(location) LIKE :search", search: "%#{query}%")
  end
end

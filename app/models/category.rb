class Category < ApplicationRecord
  enum :kind, %i[expense income].index_with(&:to_s)
end

class Recipe < ApplicationRecord
  belongs_to :user
  attachment :image


  # 空の投稿できないようする
  with_options presence: true do
    validates :title
    validates :body
    validates :image
  end
end

class Order < ApplicationRecord

  validates :first_name, :last_name, :email, :from_city, :to_city, presence: true
  validates :phone, presence: true, format: { with: /\A\d{11}\z/, message: "должен содержать ровно 11 цифр" }

  def self.ransackable_attributes(auth_object = nil)
    %w[
      created_at distance email first_name from_city height id
      last_name length middle_name phone price to_city updated_at weight width
    ]
  end
end
class Cat < ActiveRecord::Base
  attr_accessible :name, :age, :birth_date, :color, :sex, :user_id

  validates :name, :age, :birth_date, :color, :sex, :user_id, :presence => true
  validates :color, :inclusion => {in: %w(red green blue),
    message: "%{value} is not a valid color"}
  validates :sex, :inclusion => {in: %w(M F),
    message: "%{value} is not a valid sex"}

  has_many :rental_requests,
    :primary_key => :id,
    :foreign_key => :cat_id,
    :class_name => "CatRentalRequest",
    :dependent => :destroy

  belongs_to :owner,
    :primary_key => :id,
    :foreign_key => :user_id,
    :class_name => "User"

end
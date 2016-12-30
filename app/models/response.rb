class Response < ApplicationRecord
  has_many :response_properties, dependent: :destroy
  has_many :response_subproperties, through: :response_property, dependent: :destroy
  belongs_to :form

end

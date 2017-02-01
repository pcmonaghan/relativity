class Form < ApplicationRecord
  has_many :responses, dependent: :destroy
  has_many :response_properties, through: :responses
  has_many :field_keys, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :model_ranks, dependent: :destroy
  belongs_to :user, optional: true
end

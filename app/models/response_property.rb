class ResponseProperty < ApplicationRecord
  belongs_to :response
  has_many :response_subproperties, dependent: :destroy
end

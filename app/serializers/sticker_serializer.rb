# frozen_string_literal: true

class StickerSerializer < ApplicationSerializer
  has_one :collection
  attribute :uuid, key: :id
  attributes :number, :quantity, :status, :number_of_repeated
end

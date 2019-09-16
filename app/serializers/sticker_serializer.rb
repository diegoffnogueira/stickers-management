class StickerSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :number, :quantity
  has_one :collection
end

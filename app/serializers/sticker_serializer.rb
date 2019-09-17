class StickerSerializer < ActiveModel::Serializer
  has_one :collection
  attribute :uuid, key: :id
  attributes :number, :quantity, :status, :number_of_repeated

  STATUS = [REPEATED = 'REPEATED', USED = 'USED', MISSING = 'MISSING'].freeze

  def status
    if quantity.zero?
      Sticker::MISSING
    elsif quantity == 1
      Sticker::USED
    else
      Sticker::REPEATED
    end
  end

  def number_of_repeated
    return quantity - 1 if quantity > 1

    0
  end
end

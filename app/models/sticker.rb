# frozen_string_literal: true

class Sticker < ApplicationRecord
  belongs_to :collection

  scope :by_uuid, (->(uuid) { where(uuid: uuid) })
  scope :by_collection, (->(collection) { where('collection_id = ?', collection.id).order(:number) })

  after_initialize :set_uuid

  validates :number, :quantity, :uuid, presence: true
  validates :uuid, uniqueness: true

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

  def set_uuid
    self.uuid ||= SecureRandom.uuid
  end
end

# frozen_string_literal: true

class Sticker < ApplicationRecord
  belongs_to :collection

  scope :by_uuid, (->(uuid) { where(uuid: uuid) })
  scope :by_collection, (->(collection) { where('collection_id = ?', collection.id).order(:number) })

  after_initialize :set_uuid

  validates :number, :quantity, :uuid, presence: true
  validates :uuid, uniqueness: true

  def set_uuid
    self.uuid ||= SecureRandom.uuid
  end
end

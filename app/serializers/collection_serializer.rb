# frozen_string_literal: true

class CollectionSerializer < ApplicationSerializer
  has_one :album
  has_one :collector
end

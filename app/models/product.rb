# frozen_string_literal: true

class Product < ApplicationRecord
  include AASM

  aasm column: :state do
    state :draft
    state :published

    event :publish do
      transitions from: :draft, to: :published
    end

    event :unpublish do
      transitions from: :published, to: :draft
    end
  end

  validates :title, :description, :state, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
end

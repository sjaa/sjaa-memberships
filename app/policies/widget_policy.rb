# frozen_string_literal: true

class WidgetPolicy < ApplicationPolicy
  # Widgets are public and don't require authentication
  def meetup?
    true
  end
end

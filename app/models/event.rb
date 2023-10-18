class Event < ApplicationRecord
  belongs_to :user
  belongs_to :item

  def author
    if user
      user.name
    else
      "unknown"
    end
  end
end
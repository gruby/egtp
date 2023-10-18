json.extract! event, :id, :user_id, :item_id, :context_info, :created_at, :updated_at
json.url event_url(event, format: :json)

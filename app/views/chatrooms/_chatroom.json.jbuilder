json.extract! chatroom, :id, :topic, :created_at, :updated_at
json.url chatroom_url(chatroom, format: :json)

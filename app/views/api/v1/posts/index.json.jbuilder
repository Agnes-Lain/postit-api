json.array! @posts do |post|
  json.extract! post, :id, :title, :content, :user_id
  json.user post.user, :user_name, :email
end


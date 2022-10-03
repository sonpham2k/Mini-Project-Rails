json.array! @posts do |post|
    json.id post.id
    json.title post.title
    json.user_id post.user_id


    json.author do
      json.partial! 'users/user', users: post.user
    end

    json.created_at post.created_at
  end
  
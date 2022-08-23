class User < ApplicationRecord
    has_many :active_relationships, class_name: 'Relationship',
                                    foreign_key: 'follower_id',
                                    dependent: :destroy
    has_many :passive_relationships, class_name: 'Relationshi',
                                    foreign_key: 'followed_id',
                                    dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower
    has_many :comment
    has_many :post
    has_many :result_vote
end
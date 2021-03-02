class Follow < ApplicationRecord

    belongs_to :follower , foreign_key 'user_id', class_name: 'User'
    belo
# frozen_string_literal: true

class User < ActiveRecord::Base
  has_secure_password
  has_secure_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  # include DeviseTokenAuth::Concerns::User
  validates :email, uniqueness: true

  has_many :posts # delete_allはいらない
  has_many :folders, dependent: :delete_all

  # フォローをする関係
  has_many :active_relationships,       # 今つけた名前
  class_name: "UserRelation", # テーブルを参照
  foreign_key: "follower_id", # このカラムを使う
  dependent: :destroy         # ユーザー消したら関連も消えるよ

  # フォロワーの関係
  has_many :passive_relationships,      # 今つけた名前
      class_name: "UserRelation", # テーブルを参照
      foreign_key: "followed_id", # このカラムを使う
      dependent: :destroy         # ユーザー消したら関連も消えるよ


  # 一覧画面で使用できるようにする user.followers で使える
  has_many :followings,
      through: :active_relationships,
      source: :followed # followingsはfollowed idの集合体

  has_many :followers,
      through: :passive_relationships,
      source: :follower  # followingsはfollower idの集合体

      
  # フォローする
  def follow(user_id)
    active_relationships.create(followed_id: user_id)
  end

  # フォロー解除
  def unfollow(user_id)
    active_relationships.find_by(followed_id: user_id).destroy
  end

  # 現在のユーザーがフォローしてるか
  def following?(user)
    followings.include?(user)
  end
end

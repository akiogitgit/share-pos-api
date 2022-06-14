# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
if Rails.env == "development"

  # 投稿作成
  (1..2).each do |i|
    User.create(
      username: "testuser#{i}",
      nickname: "あきお#{i}",
      password: "anpan#{i}",
      password_confirmation: "anpan",
    )
  end

  # タグ作成
  (1..50).each do |i|
    Post.create(
      comment: "すごくいい！#{i*100}円あげる",
      url: "https://tlms.tsc.u-tokai.ac.jp/course/view.php?id=63304&section=#{i}",
      published: i % 2 == 0,
      evaluation: (i % 5) + 1,
      user_id: (i % 2) + 1,
    )
  end
end
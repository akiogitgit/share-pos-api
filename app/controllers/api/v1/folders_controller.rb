class Api::V1::FoldersController < ApplicationController
  before_action :set_folder, only: %i[ show update destroy ]
  before_action :authenticate

  # 自分のフォルダ名一覧
  def index
    # @folders = Folder.all
    @folders = current_user.folders.order(:created_at)
    render json: {data: @folders, message: "successfully get folders"},
    status: 200
  end

  # 指定したフォルダ内の投稿一覧
  def show
    if @folder.user_id != current_user.id
      render json: {message: "このフォルダを表示する権限がありません。"},
        status: 403
      return
    end

    # これだとpost毎のbookmark.idが入らない
    # @posts = []
    # @folder.folder_post_relations.order(created_at: :desc).each do |relation|
    #   post = Post.find(relation.post.id)
    #   @posts.push(post)
    # end

    # 中間テーブルid、Post一覧、そのPostのuser情報も必要
    # 他人の投稿が途中で非公開になった時の処理
    @posts = @folder.folder_post_relations.order(created_at: :desc).map do |relation|
      post = relation.post
      if !(current_user.id != post.user_id && post.published == false)
        {
          id: post.id,
          comment: post.comment,
          url: post.url,
          evaluation: post.evaluation,
          published: post.published,
          user_id: post.user_id,
          created_at: post.created_at,
          updated_at: post.updated_at,

          bookmark: {
            id: relation.id
          },
          meta_info: {
            image: post.meta_info.image,
            title: post.meta_info.title,
          },
          user: {
            id: post.user.id,
            username: post.user.username,
          },
          reply_comments: post.reply_comments
        }
      end
    end

    # 配列のnilを取り除く
    @posts = @posts.compact

    render json: {
      data: {
        id: @folder.id,
        name: @folder.name,
        posts:@posts
      },
      message: "successfully get posts"}, status: 200
  end

  # 新しいフォルダ作成
  def create
    @folder = Folder.new(folder_params)

    if @folder.save
      render json: {data: @folder, message: "successfully create folder"},
        status: 200
    else
      render json: {message: @folder.errors.full_messages},
        status: 400
    end
  end

  # フォルダ名変更
  def update
    if @folder.user_id != current_user.id
      render json: {message: "更新する権限がありません。"},
        status: 403
      return
    end

    if @folder.update(folder_params)
      render json: {data: @folder, message: "successfully update folder"},
        status: 200
    else
      render json: {message: @folder.errors.full_messages},
        status: 400
    end
  end

  # フォルダ削除 delete_all で 中間テーブルも削除
  def destroy
    if @folder.user_id != current_user.id
      render json: {message: "削除する権限がありません。"},
        status: 403
      return
    end

    if @folder.destroy
      render json: {data: @folder, message: "successfully delete folder"},
        status: 200
    else
      render json: {message: @folder.errors.full_messages},
        status: 400
    end
  end

  private
    def set_folder
      @folder = Folder.find(params[:id])
    end

    def folder_params
      params.permit(:name).merge(user_id: current_user.id)
    end
end

class Api::V1::FolderPostRelationsController < ApplicationController
  before_action :set_bookmark, only: %i[destroy]
  before_action :authenticate

  # フォルダに投稿を追加
  def create
    @bookmark = FolderPostRelation.new(bookmark_params)
    post = Post.find(@bookmark.post_id)
    folder = Folder.find(@bookmark.folder_id)

    # 他人の非公開の投稿の時
    if post.published == false && current_user.id != post.user_id
      render status: 404
      return
    end

    if folder.user_id != current_user.id
      render json: {message: "このフォルダに追加する権限がありません。"},
      status: 403
      return
    end

    if @bookmark.save
      # 欲しいのは folder.id, post情報(usernameも含む)
      # @post = {
      #   post: @bookmark.post,
      #   bookmark: {
      #     id: @bookmark.id
      #   },
      #   folder: {
      #     id: @bookmark.folder_id
      #   }
      # }
      @post = {
        id: @bookmark.post.id,
        comment: @bookmark.post.comment,
        url: @bookmark.post.url,
        evaluation: @bookmark.post.evaluation,
        published: @bookmark.post.published,
        user_id: @bookmark.post.user_id,
        created_at: @bookmark.post.created_at,
        updated_at: @bookmark.post.updated_at,
        user: {
          username: @bookmark.post.user.username
        },
        bookmark: {
          id: @bookmark.id
        },
        folder: {
          id: @bookmark.folder_id
        }
      }
      render json: {data: @post, message: "successfully create bookmark"},
        status: 200
    else
      render json: {message: @bookmark.errors.full_messages},
        status: 400
    end
  end

  # フォルダの記事を削除
  # どの形のレスポンスが、フロントにいいか
  def destroy
    if @bookmark.folder.user_id != current_user.id
      render json: {message: "削除する権限がありません。"},
        status: 403
      return
    end

    if @bookmark.destroy
      render json: {data: @bookmark, message: "successfully delete bookmark"},
        status: 200
    else
      render json: {message: @bookmark.errors.full_messages},
        status: 400
    end
  end

  private
    def set_bookmark
      @bookmark = FolderPostRelation.find(params[:id])
    end

    def bookmark_params
      params.permit(:folder_id, :post_id)
    end
end

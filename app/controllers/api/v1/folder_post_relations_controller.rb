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
      render json: {data: @bookmark.post, message: "successfully added post to folder"},
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

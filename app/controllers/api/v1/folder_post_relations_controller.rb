class Api::V1::FolderPostRelationsController < ApplicationController
  before_action :set_bookmark, only: %i[destroy]
  before_action :authenticate_user!, only: %i[create destroy]

  # 全部認証が必要にする
  def index
    @bookmarks = FolderPostRelation.all

    render json: @bookmarks
  end

  # 指定したフォルダ内の投稿一覧
  # def show
  #   render json: @folder_post_relation
  # end

  # フォルダに記事を追加
  def create
    @bookmark = FolderPostRelation.new(bookmark_params)
    post = Post.find(@bookmark.post_id)
    folder = Folder.find(@bookmark.folder_id)

    if post.published == false && current_user.id != post.user_id
      render json: {message: "その投稿は非公開"},
      status: 403 # 後に404にする
      return
    end

    if folder.user_id != current_user.id
      render json: {message: "そのフォルダは違う"},
      status: 403
      return
    end

    if @bookmark.save
      render json: {data: @bookmark, message: "successfully create folder"},
        status: 200
    else
      render json: {message: @bookmark.errors.full_messages},
        status: 400
    end
  end

  # def update
  #   if @bookmark.update(bookmark_params)
  #     render json: @bookmark
  #   else
  #     render json: @bookmark.errors, status: :unprocessable_entity
  #   end
  # end

  # フォルダの記事を削除
  def destroy
    @bookmark.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookmark
      @bookmark = FolderPostRelation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bookmark_params
      params.require(:bookmark).permit(:folder_id, :post_id)
    end
end

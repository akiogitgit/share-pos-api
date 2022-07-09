class Api::V1::FoldersController < ApplicationController
  before_action :set_folder, only: %i[ show update destroy ]
  before_action :authenticate_user!

  # 自分のフォルダ名一覧
  def index
    # @folders = Folder.all
    @folders = current_user.folders
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

    # bookmark.idを加えて返す
    @posts = @folder.folder_post_relations.map do |relation|
      {
        id: relation.post.id,
        comment: relation.post.comment,
        url: relation.post.url,
        evaluation: relation.post.evaluation,
        published: relation.post.published,
        user_id: relation.post.user_id,
        created_at: relation.post.created_at,
        updated_at: relation.post.updated_at,
        bookmark_id: relation.id,
      }
    end
    render json: {data: {name: @folder.name, posts:@posts}, message: "successfully get posts"},
      status: 200
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
      params.require(:folder).permit(:name).merge(user_id: current_user.id)
    end
end

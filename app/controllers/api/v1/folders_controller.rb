class Api::V1::FoldersController < ApplicationController
  before_action :set_folder, only: %i[ show update destroy ]

  # 全部認証が必要にする

  # 自分のフォルダ名一覧
  def index
    @folders = Folder.all

    render json: @folders
  end

  # 指定したフォルダ内の投稿一覧
  def show
    render json: @folder
  end

  # 新しいフォルダ作成
  def create
    @folder = Folder.new(folder_params)

    if @folder.save
      render json: @folder, status: :created, location: @folder
    else
      render json: @folder.errors, status: :unprocessable_entity
    end
  end

  # フォルダ名変更
  def update
    if @folder.update(folder_params)
      render json: @folder
    else
      render json: @folder.errors, status: :unprocessable_entity
    end
  end

  # フォルダ削除 delete_all で 中間テーブルも削除
  def destroy
    @folder.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = Folder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def folder_params
      params.require(:folder).permit(:user_id, :name)
    end
end

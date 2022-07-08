class Api::V1::FolderPostRelationsController < ApplicationController
  # before_action :set_folder_post_relation, only: %i[ show update destroy ]

  # 全部認証が必要にする
  def index
    @folder_post_relations = FolderPostRelation.all

    render json: @folder_post_relations
  end

  # 指定したフォルダ内の投稿一覧
  # def show
  #   render json: @folder_post_relation
  # end

  # フォルダに記事を追加
  def create
    @folder_post_relations = Folder.new(folder_post_relation_params)

    if @folder_post_relations.save
      render json: @folder_post_relations, status: :created, location: @folder_post_relations
    else
      render json: @folder_post_relations.errors, status: :unprocessable_entity
    end
  end

  # def update
  #   if @folder_post_relations.update(folder_post_relation_params)
  #     render json: @folder_post_relations
  #   else
  #     render json: @folder_post_relations.errors, status: :unprocessable_entity
  #   end
  # end

  # フォルダの記事を削除
  def destroy
    @folder_post_relations.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_folder_post_relation
    #   @folder_post_relations = FolderPostRelation.find(params[:id])
    # end

    # # Only allow a list of trusted parameters through.
    # def folder_post_relation_params
    #   params.require(:folder_post_relations).permit(:folder_id, :post_id)
    # end
end

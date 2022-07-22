class Api::V1::MetasController < ApplicationController

  # URLを受け取ると、meta情報を返す
  def index
    if params[:url].nil?
      render json: {data: params,message: "urlを付与して下さい"},
        status: 400
      return
    end

    meta = MetaInspector.new(params[:url])
    description = meta.description
    title = meta.title
    image = meta.images.best
    
    render json: {data:{title:title,description:description, image: image} , message: "successfully get meta info"},
      status: 200
  end
end
class Api::V1::ScrapingsController < ApplicationController

  def create
    meta = MetaInspector.new(params[:url])
    description = meta.description
    title = meta.title
    image = meta.images.best
    
    render json: {data:{title:title,description:description, image: image} , message: "successfully get meta info"},
      status: 200
  end
end
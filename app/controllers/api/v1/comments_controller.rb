class Api::V1::CommentsController < Api::V1::BaseController

  def index
    @match = Match.find(params[:id])
    comment = Comment.includes(:match_id, image_attachment: :blob).all
    render json: @comment.as_json(only: [:match_id, :name], methods: :image_url)
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render :show, status: :created
    else
      render_error
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, images: [])
  end

  def render_error
    render json: { errors: @comment.errors.full_messages },
    status: :unprocessable_entity
  end
end

# add jbuilder file

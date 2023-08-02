class Api::V1::CommentsController < Api::V1::BaseController

  def index
    @match = Match.find(params[:match_id])
    @comments = @match.comments
    render json: @comments
  end


  def create
    @comment = Comment.new(comment_params)
    @comment.match_id = params[:match_id]
    if @comment.save
      render json: @comment, serializer: Api::V1::CommentSerializer
    else
      render_error
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:message, :owner_id, :match_id)
  end

  def render_error
    render json: { errors: @comment.errors.full_messages },
    status: :unprocessable_entity
  end
end

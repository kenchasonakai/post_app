class PostTemplatesController < ApplicationController
  def new
    @post_template = PostTemplate.new
  end

  def create
    @post_template = PostTemplate.new(post_template_params)

    if @post_template.save
      redirect_to new_post_path, notice: "テンプレートを作成しました"
    else
      flash.now[:alert] = "テンプレートの作成に失敗しました\n#{@post_template.errors.full_messages.join('\n')}"
      render :new, status: :unprocessable_entity
    end
  end

  def index
    respond_to do |format|
      format.html do
        @post_templates = PostTemplate.all
      end
      format.json do
        render json: PostTemplate.select(:id, :title, :content).embed_contents(user_name: current_user.nickname)
      end
    end
  end

  private

  def post_template_params
    params.require(:post_template).permit(:title, :content)
  end
end

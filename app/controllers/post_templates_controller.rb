class PostTemplatesController < ApplicationController
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

  def new
    @post_template = PostTemplate.new
  end

  def create
    @post_template = current_user.post_templates.build(post_template_params)

    if @post_template.save
      redirect_to post_templates_path, notice: "テンプレートを作成しました"
    else
      flash.now[:alert] = "テンプレートの作成に失敗しました\n#{@post_template.errors.full_messages.join('\n')}"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post_template = PostTemplate.find(params[:id])
  end

  def edit
    @post_template = PostTemplate.find(params[:id])
  end

  def update
    @post_template = PostTemplate.find(params[:id])

    if @post_template.update(post_template_params)
      redirect_to post_template_path(@post_template), notice: "テンプレートを更新しました"
    else
      flash.now[:alert] = "テンプレートの更新に失敗しました\n#{@post_template.errors.full_messages.join('\n')}"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post_template = current_user.post_templates.find(params[:id])
    post_template.destroy!
    redirect_to post_templates_path, notice: "テンプレートを削除しました"
  end

  private

  def post_template_params
    params.require(:post_template).permit(:title, :content)
  end
end

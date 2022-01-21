class PostsController < ApplicationController
  before_action :authorize, :current_user, :is_Admin
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    if @is_Admin == true
      @posts = Post.search_post(params[:keyword])
                   .where(deleted_user_id: nil)
    else
      @posts = Post.search_post(params[:keyword])
                   .where(created_user_id: @current_user)
                   .where(deleted_user_id: nil)
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    restrict()
  end

  # GET /posts/new
  def new
    @post = Post.new()
  end

  # GET /posts/1/edit
  def edit
    restrict()
    @post = Post.find_by_id(params[:id])
    @update_form = UpdateForm.new(UpdateForm.initialize(@post))
  end

  def create_confirm
    @post = Post.new(post_params)
    unless @post.valid?
        render :new
    end
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(update_form_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @update_form.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_confirm
    @update_form = UpdateForm.new(update_form_params)
    unless @update_form.valid?
        render :edit
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.delete_post(@current_user.id)
    
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully deleted." }
      format.json { head :no_content }
    end
  end


  def import
    if !params[:file].present?
      flash[:error] = "Select file to import!"
      redirect_to upload_csv_posts_path
    elsif !File.extname(params[:file]).eql?(".csv")
      flash[:error] = "Select CSV file."
      redirect_to upload_csv_posts_path
    else
      Post.import_file(params[:file].path)
      redirect_to root_path, notice: "Posts imported."
    end

  end

  def download
    respond_to do |format|
      format.csv { send_data Post.to_csv, filename: "posts-#{Date.today}.csv" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :description, :status, :created_user_id, :updated_user_id, :deleted_user_id)
      .with_defaults(status: 1)
    end

    def update_form_params
      params.require(:update_form).permit(:id, :title, :description, :status, :updated_user_id)
    end

    def restrict
      if !@is_Admin
        if @post.created_user_id == @current_user.id
        
        else
          redirect_to posts_path
        end
      end
    end
end

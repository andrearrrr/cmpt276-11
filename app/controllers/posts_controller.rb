class PostsController < ApplicationController
before_action :logged_in_user, only: [:create, :destroy]

	def create
		@post = current_user.posts.build(post_params)
	    if @post.save
	      flash[:success] = "Post created!"
	      redirect_to root_url
	    else
	      render 'posts/show'
	    end
	end

	def destroy
	end

	def index
		@user = User.find(params[:id])
		@posts = @user.posts.paginate(page: params[:page])
		@post = current_user.posts.build if logged_in?

	end

	def show
		@post = current_user.posts.build if logged_in?

	end

end

class MicropostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			@micropost.save_hashtag
			@feed_items = current_user.feed.paginate(page: 1)
			flash[:success] = "Micropost created!"
			respond_to do |format|
				format.html {redirect_to request.referrer || root_url}
				format.js
			end
		else
			@feed_items = []
			render 'static_pages/home'
		end
	end


	
	def destroy
		hashtag_ids = @micropost.hashtags.ids
		if hashtag_ids.count == 1
			hashtag_id = hashtag_ids[0]
			hashtag_ids.clear
		end
		if @micropost.destroy
			if hashtag_ids.any?
				hashtag_ids.each do |hashtag_id|
					if MicropostHashtag.find_by(hashtag_id: hashtag_id).nil?
						Hashtag.find(hashtag_id).destroy
					end
				end	
			end
			if hashtag_id
				if MicropostHashtag.find_by(hashtag_id: hashtag_id).nil?
					Hashtag.find(hashtag_id).destroy
				end
			end
		end
		flash[:success] = "Micropost deleted"
		redirect_to request.referrer || root_url
	end

	def hashtag
		if logged_in?
			@micropost = current_user.microposts.build
		end	
    @hashtag = Hashtag.find_by(name: params[:name])
    if @hashtag.nil?
      @nil_hashtag = params[:name]
      return
    end
    @microposts = @hashtag.hashtag_microposts.paginate(page: params[:page])
	end

	private
		def micropost_params
			params.require(:micropost).permit(:content, :picture)
		end

		def correct_user
			@micropost = current_user.microposts.find_by(id: params[:id])
			redirect_to root_url if @micropost.nil?
		end
end

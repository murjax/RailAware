class VotesController < ApplicationController
	def create
		flash[:notice] = ["Vote Received!"]
		logger.debug(current_user)
		@report = Report.find(params[:data][0])
		@rating = @report.rating.to_i
		@newrating = @rating + (params[:data][1]).to_i
		@report.rating = @newrating
		@report.save
		
		@vote = Vote.new()
		@vote.username = params[:data][2]
		@vote.report_id = params[:data][0]
		@vote.save
		
		@user = User.find_by_username(@report.username)
		@user.votecount = @user.votecount.to_i + 1
		
		if params[:data[1]].to_i == 0
			
			if @user.votecount.to_i.between?(0, 6)
				@user.rating = (@user.rating.to_i * 0.1) + @user.rating.to_i
			elsif @user.votecount.to_i.between?(5, 11)
				@user.rating = (@user.rating.to_i * 0.08) + @user.rating.to_i
			elsif @user.votecount.to_i.between?(9, 21)
				@user.rating = (@user.rating.to_i * 0.05) + @user.rating.to_i
			elsif @user.votecount.to_i.between?(19, 41)
				@user.rating = (@user.rating.to_i * 0.03) + @user.rating.to_i
			elsif @user.votecount.to_i.between?(39, 81)
				@user.rating = (@user.rating.to_i * 0.02) + @user.rating.to_i
			else
				@user.rating = (@user.rating.to_i * 0.01) + @user.rating.to_i
			end
		else
			
			if @user.votecount.to_i.between?(0, 6)
				@user.rating = @user.rating.to_i - (@user.rating.to_i * 0.1)
			elsif @user.votecount.to_i.between?(5, 11)
				@user.rating = @user.rating.to_i - (@user.rating.to_i * 0.08)
			elsif @user.votecount.to_i.between?(9, 21)
				@user.rating = @user.rating.to_i - (@user.rating.to_i * 0.05)
			elsif @user.votecount.to_i.between?(19, 41)
				@user.rating = @user.rating.to_i - (@user.rating.to_i * 0.03)
			elsif @user.votecount.to_i.between?(39, 81)
				@user.rating = @user.rating.to_i - (@user.rating.to_i * 0.02)
			else
				@user.rating = @user.rating.to_i - (@user.rating.to_i * 0.01)
			end
		end
		
		
		@user.save
		
		redirect_to(:action => 'show')
	end
end
class InterestController < ApplicationController

  def index
    if params[:search].present?
      @subjects = Subject.search(params[:search]).paginate(:per_page => 10, :page => params[:page])
      # @locations = @locations.paginate(:page => 1, :per_page => 2)
    else
      @subjects = Subject.all.sort_by(&:name)
    end
  end

  def create
    # @subjects = Subject.all
    current_user.interests = params[:interest][:interests].to_json # add back the params[:interest][:interests].to_json it is reason subjects save
    if current_user.save
    else
      flash[:danger] = "Something went wrong!"
    end
    redirect_to root_path
  end

end

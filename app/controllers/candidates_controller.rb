class CandidatesController < ApplicationController
  def index
    @candidates = Candidate.all
  end

  def new
    @candidate = Candidate.new
  end

  def create
    # binding.pry
    # render html: 'abc'
    @candidate = Candidate.new(candidate_params)
    
    if @candidate.save
      flash[:notice] = '新增成功'
      redirect_to '/'
    else
      flash[:notice] = '新增失敗'
      # 借用 new 的 template 來用

      # render action: :new
      render :new
      # 等效於以下這行
      # render file: '../views/candidates/new.html.erb'
    end
  end

  private
  def candidate_params
    params.require(:candidate).permit(:name, :age, :party, :politics)
  end

end
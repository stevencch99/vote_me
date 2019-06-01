class CandidatesController < ApplicationController
  before_action :find_candidate, only: [:show, :edit, :update, :destroy]
  def index
    @candidates = Candidate.all
  end

  def show
  end

  def edit
  end

  def update
    if @candidate.update(candidate_params)
      redirect_to root_path, notice: '更新成功'
    else
      render :edit
    end
  end

  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)
    
    if @candidate.save
      redirect_to root_path, notice: '新增成功'
    else
      # 註解掉 flash[] 因為輸入失敗會直接以紅框提醒，故不需要另外再提醒失敗
      # flash[:notice] = '新增失敗'
      # 借用 new 的 template 來用

      # render action: :new
      render :new
      # 等效於以下這行
      # render file: '../views/candidates/new.html.erb'
    end
  end

  def destroy
    @candidate.destroy
    redirect_to root_path, notice: '候選人已刪除'
  end

  private

  def find_candidate
    # .find method, a shorter way to find data, but less params options to operate
    # @candidate = Candidate.find(params[:id])
    @candidate = Candidate.find_by(id: params[:id])
  end
  
  def candidate_params
    params.require(:candidate).permit(:name, :age, :party, :politics)
  end

end
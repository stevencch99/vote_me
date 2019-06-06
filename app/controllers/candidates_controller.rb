class CandidatesController < ApplicationController
  before_action :find_candidate, only: [:show, :edit, :update, :destroy, :vote]
  # before_action only 的反義詞
  # before_action :find_candidate, except: [:index, :new, :create]

  def index
    # @candidates = Candidate.all
    # using kaminari gem make limit candidate data displayed
    @candidates = Candidate.all.page(params[:page]).per(3)
  end

  def show
  end

  def edit
    redirect_to root_path, alert: '請先登入' unless user_signed_in?
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
  
  def vote
    # Option 1. 由 “票” 的角度新增候選人：
    # 創造一張票，寫進候選人和 client IP
    # Vote.create(candidate: @candidate, ip_address: request.remote_ip)

    # Option 2. 由候選人的角度寫入票數(比較適合寫在 candidates controller 這裡)
    @candidate.votes.create(ip_address: request.remote_ip)
    
    redirect_to root_path, notice: '投票完成'
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
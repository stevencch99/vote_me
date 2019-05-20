class CandidatesController < ApplicationController
  def index
  end

  def new
    @candidate = Candidate.new
  end

  def create
    # binding.pry
    # render html: 'abc'
    candidate_params = params.require(:candidate).permit(:name, :age, :party, :polititcs)
    @candidate = Candidate.new(candidate_params)
    
    if @candidate.save
      redirect_to '/'
    else
    end
  end
end
namespace :db do
  desc '更新投票數'
  task update_vote: :environment do
    print '開始更新投票數'
    Candidate.all.each do |candidate|
      Candidate.reset_counters(candidate.id, :votes)
      print '.'
    end
    puts '完成更新！'
  end
end

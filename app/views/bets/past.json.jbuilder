json.friendsPast @fbets do |bet|
  json.extract! bet, :id, :verb, :amount, :noun, :duration, :owner, :stakeAmount, :stakeType, :initial, :status, :created_at, :updated_at

  p = 0 # percent complete
  bet.updates.each do |u|
    p = p + u.value
  end
  tp = (bet.initial + p) / (bet.initial + bet.amount) * 100 
  tp = 0 if bet.verb == 'Lose' #auto-zero, then real number if we can
  tp = (bet.updates.last.value / bet.amount * 100).to_i if bet.verb == 'Lose' && bet.updates.last && bet.updates.last.value > 0
  tp = bet.updates.count*100 / bet.duration if bet.noun.downcase == 'smoking'
  json.progress tp.to_i

  opps = {accepted: [], others: []}
  bet.invites.each do |i|
    if i.status == "accepted"
      opps[:accepted].push i.invitee 
    else
      opps[:others].push i.invitee 
    end
  end
  json.opponents opps
end

json.myPast @bets do |bet|
  json.extract! bet, :id, :verb, :amount, :noun, :duration, :owner, :stakeAmount, :stakeType, :initial, :status, :created_at, :updated_at

  p = 0 # percent complete
  bet.updates.each do |u|
    p = p + u.value
  end
  tp = (bet.initial + p) / (bet.initial + bet.amount) * 100 
  tp = 0 if bet.verb == 'Lose' #auto-zero, then real number if we can
  tp = (bet.updates.last.value / bet.amount * 100).to_i if bet.verb == 'Lose' && bet.updates.last && bet.updates.last.value > 0
  tp = bet.updates.count*100 / bet.duration if bet.noun.downcase == 'smoking'
  json.progress tp.to_i

  opps = {accepted: [], others: []}
  bet.invites.each do |i|
    if i.status == "accepted"
      opps[:accepted].push i.invitee 
    else
      opps[:others].push i.invitee 
    end
  end
  json.opponents opps
end

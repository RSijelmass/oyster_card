# require 'oystercard'
#
# describe Oystercard do
#
#   it "should notify incomplete journey when user forgets to touch in" do
#     card = Oystercard.new
#     station1 = Station.new("Old street", 1)
#     card.top_up(10)
#     expect(card.touch_out(station1)).to eq "You forgot to touch in: you'll have an incomplete journey list"
#   end
#
#   it "should notify user on next touch in if they forgot to touch out" do
#     card = Oystercard.new
#     station1 = Station.new("Old street", 1)
#     station2 = Station.new("Moorgate", 1)
#     card.top_up(10)
#     card.touch_in(station1)
#     expect(card.touch_in(station2)).to eq "You forgot to touch out: you'll have an incomplete journey list"
#   end
#
#   #penalty fare deducated from balance if user forgets to touch in
#
#   #penalty fare deducated from balance if user forgets to touch out
#
# end

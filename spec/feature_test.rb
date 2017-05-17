# DEPRICATED

# require './lib/oystercard'
#
# def assert_equals(expected_result, test_statement)
#   if test_statement == expected_result
#     :pass
#   else
#     "expected: #{expected_result} got: #{test_statement}"
#   end
# end
#
# # 1 creates a new oystercard
# oystercard = Oystercard.new
#
# # 2 returns balance
# oystercard.balance
#
# # 3 allows user to top up
# oystercard.top_up(10)
#
# # 4 allows fare to be deducted
# oystercard.deduct_fare(5)
#
# # 5 allows oystercard to touch_in
# oystercard.touch_in
#
# # 6 allows touch_in minimum balance is £1
# oystercard.deduct_fare(5)
# oystercard.touch_in # should raise_error

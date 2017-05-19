## Oystercard Challenge

The TfL infamous Oystercard, holding one's currency for the London public transportation.

#### Objects

###### Oystercard
* Behaviour:
- Touch in at specific starting station
- Touch out at specific starting station
- Top up balance, unless maximum balance is reached
- Deduct a fare, unless it will exceed the minimum balance
  - Takes into consideration zones it travels through
  - Deduct a penalty fare, if touch_in or touch_out has failed

* State:
- A journey log
- Constants: minimum and maximum balance
- Current balance

###### Journey Log
* Behaviour:
- Records all complete and incomplete journeys taken by Oystercard it's called by
- Calculates the fare of specific journeys
- Creates new journey whenever a journey is started

* State:
- The journey history

###### Journey
* Behaviour:
- Starts a journey at specific station
- Ends a journey at specific station
- Checks if the journey is completed when called

* State
- Entry station (given as argument)
- Exit station (given as argument)

###### Station
* State:
- Station name (given as argument at initialisation)
- Station zone (given as argument at initialisation)


#### User Stories
'''
In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to protect my money
As a customer
I don't want to put too much money on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers
As a customer
I need to touch in and out

In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

In order to pay for my journey
As a customer
I need to know where I've travelled from

In order to know where I have been
As a customer
I want to see to all my previous trips

In order to know how far I have travelled
As a customer
I want to know what zone a station is in

In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated
'''

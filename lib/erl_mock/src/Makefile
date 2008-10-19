include ../vsn.mk
include ../../../include.mk

test: all
	$(ERL) -pa ../ebin -s mock_test tests -s erlang halt


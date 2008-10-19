%%% Copyright (c) 2008 Nicolas Charpentier
%%% All rights reserved.
%%% See file COPYING.

-module (my_module).

-export ([who /0]).
-export ([ping /1]).

who () ->
    "I'm the mocked code".

ping (Host) ->
    {mock, Host}.

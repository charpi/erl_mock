%%% Copyright (c) 2008 Nicolas Charpentier
%%% All rights reserved.
%%% See file COPYING.

-module (my_module).

-export ([who /0]).
-export ([ping /1]).

who () ->
    "i'm the production code".

ping (Host) ->
    {pong, Host}.

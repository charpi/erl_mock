%%% Copyright (c) 2008 Nicolas Charpentier
%%% All rights reserved.
%%% See file COPYING.

-module (mock_test).

-test ([lazy_way]).
-test ([dynamic_way]).

-export([lazy_way /0]).
-export([dynamic_way /0]).
-export ([tests /0]).

tests () ->
    lazy_way (),
    dynamic_way (),
    ok.

lazy_way () ->
    "i'm the production code" = my_module: who(),
    mock: replace_module (my_module, my_mock_module),
    "I'm the mocked code" = my_module: who (),
    mock: uninstall (my_module),
    "i'm the production code" = my_module: who (),
    ok.

dynamic_way () ->
    "i'm the production code" = my_module: who (),
    {pong,host} = my_module: ping (host),

    mock: start (),
    mock: add_module(my_module),
    mock: set_answer (my_module, who, "I'm the mocked code"),
    "I'm the mocked code" = my_module: who (),
    mock: set_answer (my_module, who, "Oops did it wrong"),
    "Oops did it wrong" = my_module: who (),

    [{my_module, who, []}, {my_module, who, []}] =  mock: calls (),
    [] =  mock: calls (),
    
    case catch my_module: ping(host) of
	error_no_response -> ok;
	Other -> exit({unexepected_mock_response, Other})
    end,
    
    mock: set_answer (my_module, ping, {pang, mock_host}),
    {pang, mock_host} = my_module: ping(last_host),

    [{my_module, ping, [host]},{my_module, ping, [last_host]}] =  mock: calls (),

    mock: uninstall (my_module),
    "i'm the production code" = my_module: who (),
    {pong,host} = my_module: ping (host),    
    ok.



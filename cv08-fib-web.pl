
:- use_module(library('http/thread_httpd')).
:- use_module(library('http/html_write')).
:- use_module(library('http/http_session')).
:- use_module(library('http/http_error')).

%:- dynamic h/2.
%:- dynamic h/3.
fib(N,F) :- N>=0, fib(N,F,0,0,1).
fib(N,F,M,F1,F2) :-
    M < N,
    M1 is M+1,
    F3 is F1+F2,
    fib(N,F,M1,F2,F3).
fib(N,F,N,F,_).

:- use_module(library(lists)).   % list_to_set

server :-
	server(3000).

server(Port) :-
	http_server(odpoved,
		    [ port(Port),
		      timeout(20)
		    | []
		    ]).

% pouzito serverem
odpoved(Request) :-
	memberchk(path(Path), Request),
	odpoved(Path, Request).

% pouzito aplikaci
odpoved(/, _Request) :-
	stranka_uvodni.

% pouzito aplikaci
odpoved('/fib', Request) :-
	memberchk(search(Search), Request),
	memberchk(n=N, Search),
    atom_number(N, NX),
	stranka_vysledku(NX).

stranka_uvodni :-
	reply_html_page(
			title('Nth fibonacci numbert'),
			[
			 h1('Nth fibonacci number'),
			 form([
			       action('/fib'),
			       method('GET')
			      ],
			      table([align(center), border(0)],
				    [
				     tr(td([
					    input([
                           type(text),
                           name(n)
                        ]),
					    input([
						   type(submit),
						   value('Odeslat')
						  ])
					   ]))
				    ]))
			]).

stranka_vysledku(N) :-
	fib(N,F),
	reply_html_page(
			title('Nth fibonacci number'),
			[
			 h1('Nth fibonacci number'),
			 div(F)
			]).

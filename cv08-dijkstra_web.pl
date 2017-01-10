
:- use_module(library('http/thread_httpd')).
:- use_module(library('http/html_write')).
:- use_module(library('http/http_session')).
:- use_module(library('http/http_error')).

%:- dynamic h/2.
%:- dynamic h/3.
:- consult('cv07-dijkstra.pl'),consult('cv07-graf1o.pl').
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
odpoved('/dijkstra', Request) :-
	memberchk(search(Search), Request),
	memberchk(start=Start, Search),
	stranka_vysledku(Start).

%uzel(U) :- hrana(U,_);hrana(_,U).
%start_select(select(Volby)) :- setof( option([],A), (h(A,_);h(_,A);h(A,_,_);h(_,A,_)), Volby ).
start_select(Volby) :-
	findall(A, (h(A,_,_);h(_,A,_)), Vrch),
	list_to_set(Vrch,Vrcholy),
	% QaD(?) "dekorator"
	findall(option([],A), member(A,Vrcholy), Volby).

stranka_uvodni :-
	start_select(Volby),
	reply_html_page(
			title('Délky nejkratších cest'),
			[
			 h1('Délky nejkratších cest'),
			 form([
			       action('/dijkstra'),
			       method('GET')
			      ],
			      table([align(center), border(0)],
				    [
				     tr(td([
					    select(name(start), Volby),
					    input([
						   type(submit),
						   value('Odeslat')
						  ])
					   ]))
				    ]))
			]).

stranka_vysledku(Start) :-
	nejkratsi_cesta(Start,Vzdal),
	tabulka_vzdalenosti(Vzdal,Tab),
	reply_html_page(
			title('Nejkratší cesty'),
			[
			 h1('Nejkratší cesty'),
			 table(
			       [align(center), border(0)],
			       Tab
			      )
			]).

tabulka_vzdalenosti([],[]).
tabulka_vzdalenosti([U/D|Tv],
		    [tr([
			 td(U),
			 td(D)
			]) | Tt]) :-
	tabulka_vzdalenosti(Tv,Tt).

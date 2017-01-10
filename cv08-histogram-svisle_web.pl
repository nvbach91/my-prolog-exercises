
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).
%:- use_module(library(http/http_header)).
:- use_module(library(http/html_head)).

:- consult('histogram-svisle.pl').
:- http_handler(/, stranka, []).



spojene_vrstvy([],[]).
spojene_vrstvy([V|T],[Vnl|T1]) :- atomic_list_concat(V,Vs),atom_concat(Vs,'\n',Vnl),spojene_vrstvy(T,T1).
histogram_(H,S) :- svisly_histogram(H,'▓',V),spojene_vrstvy(V,S).

web(Port) :-
	setenv('BROWSER', 'firefox'),
	string_concat('http://localhost:',Port,URL),
	www_open_url(URL),
	server(Port).
web :- web(8911).
server(Port) :-
	http_server(http_dispatch, [port(Port)]).

stranka(_Request) :-
	histogram_([1,3,2,4],V),
	reply_html_page(
			[
			 title('Svislý histogram')
			],
			
			[
			 h1('Svislý histogram'),
			 pre(style='text-align: center',V)
			]
		       ).

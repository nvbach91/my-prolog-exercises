
:- use_module(library(http/http_client)).
:- use_module(library(http/http_open)).
:- use_module(library(sgml)),use_module(library(xpath)).

http_load_html(URL, DOM) :-
        setup_call_cleanup(http_open(URL, In,
				     [ timeout(60)
				     ]),
                           (
			    dtd(html, DTD),
			    load_structure(stream(In),
					   DOM,
					   [ dtd(DTD),
					     dialect(sgml),
					     shorttag(false),
					     max_errors(-1),
					     syntax_errors(quiet)
					   ])
                           ),
                           close(In)).

% (+,-)
csfd_filmy_http(Dotaz,Nazvy) :-
	atomic_list_concat(Sdot,' ',Dotaz),
	atomic_list_concat(Sdot,'+',URLdot),
	
	%atom_concat('http://www.csfd.cz/hledat/?q=',Dotaz,URL),
	atom_concat('http://www.csfd.cz/hledat/?q=',URLdot,URL),
	http_load_html(URL,Ldom),
	csfd_filmy(Ldom,Nazvy).

csfd_filmy_soubor(Cesta,Nazvy) :-
	load_html(Cesta, Ldom, []),csfd_filmy(Ldom,Nazvy).

% (+,-)
csfd_filmy(Ldom,Nazvy) :-
	Ldom=[DOM|[]],
	findall(
		H,
		xpath(DOM, //div(@id='pg-web-search')//div(@id='search-films')//div(@class=content)//h3(@class=subject)/a(text), H),
		Nazvy
	       ).

% load_html produces a list with single element which is DOM of the given file
test :-
	csfd_filmy_soubor('csfd.html',Nazvy),write(Nazvy),nl,
	csfd_filmy_http('Matrix',Nazvy2),write(Nazvy2),nl.

%:- test.

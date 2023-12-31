:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_client)).
:- use_module(library(http/json)).

:- use_module(library(random)).

:- dynamic equipo/1.
:- dynamic grupo/1.
:- dynamic listaCandidatos/1.

:- http_handler(root(sorteo), html_sorteo, []).

unicos([]).
unicos([X | R]):-
    \+ (member(X, R)),
    unicos(R).

paisesEquipos([],[]).
paisesEquipos([Equipo | Req], [Pais | Rpa]):-
    perteneceA(Equipo, Pais),
    paisesEquipos(Req, Rpa).
    
condicionPaisesDistintos(ListaEquipos):-
    paisesEquipos(ListaEquipos, ListaPaises),
    unicos(ListaPaises).

bombosEquipos([],[]).
bombosEquipos([Equipo | Req], [Bombo | Rbo]):-
    enBombo(Equipo, Bombo),
    bombosEquipos(Req, Rbo).
    
condicionBombosDistintos(ListaEquipos):-
    bombosEquipos(ListaEquipos, ListaBombos),
    unicos(ListaBombos).
    
grupoValido(ListaEquipos):-
    length(ListaEquipos, 4),
    condicionPaisesDistintos(ListaEquipos),
    condicionBombosDistintos(ListaEquipos).

generarCandidatos(ListaEquipos) :-
    findall(Equipo, equipo(Equipo), ListaEquipos).

generarGrupo(Grupo) :-
    generarCandidatos(ListaEquipos),
    generarGrupo(ListaEquipos, Grupo, 4),
    grupoValido(Grupo).

generarGrupo(_ListaEquipos, _Grupo, 0).

generarGrupo(ListaEquipos, [Equipo | RestoGrupo], N) :-
    N > 0,
    random_member(Equipo, ListaEquipos),
    N1 is N - 1,
    select(Equipo, ListaEquipos, ListaRestante),
    generarGrupo(ListaRestante, RestoGrupo, N1).

server(Port) :-					
    http_server(http_dispatch, [port(Port)]).

html_sorteo(_Request) :-
    format('Content-type: text/html~n~n'),
    format('<html><head><title>Sorteo de Champions League</title></head><body><h2>Se ha sorteado aleatoriamente el grupo de Champions League:</h2><p>Puede ser que sea necesario recargar varias veces la página para obtener un nuevo grupo.</p></body></html>~n'),
    format('<html>~n', []),
    format('<table border=1>~n'),
    generarGrupo(ListaEquipos),
    imprimir_grupo(ListaEquipos),
    format('~n</table>~n'),
    format('</html>~n', []).
    
imprimir_grupo([]).
imprimir_grupo([Equipo | EquiposRest]):-
    format('<tr>'),
    imprimir_equipo(Equipo),
    imprimir_grupo(EquiposRest).
    
imprimir_equipo(Equipo):-
    format('<td>~w</td>', [Equipo]).

%Bombos
bombo(1).
bombo(2).
bombo(3).
bombo(4).

%Equipos
equipo(barcelona).
equipo(napoles).
equipo(manchester_city).
equipo(bayern_munich).
equipo(paris_saint_germain).
equipo(benfica).
equipo(sevilla).
equipo(feyenoord).
equipo(manchester_united).
equipo(inter_milan).
equipo(borussia_dortmund).
equipo(atletico_de_madrid).
equipo(leipzig).
equipo(arsenal).
equipo(real_madrid).
equipo(porto).
equipo(shakhtar_donetsk).
equipo(salzburgo).
equipo(milan).
equipo(lazio).
equipo(estrella_roja).
equipo(sporting_braga).
equipo(psv_eindhoven).
equipo(copenhague).
equipo(union_berlin).
equipo(lens).
equipo(newcastle).
equipo(galatasaray).
equipo(real_sociedad).
equipo(young_boys).
equipo(celtic_glasgow).
equipo(royal_antwerp).

%Paises
pais(espana).
pais(inglaterra).
pais(portugal).
pais(alemania).
pais(italia).
pais(francia).
pais(belgica).
pais(escocia).
pais(suiza).
pais(holanda).
pais(austria).
pais(serbia).
pais(dinamarca).
pais(ucrania).
pais(turquia).

perteneceA(barcelona, espana).
perteneceA(napoles, italia).
perteneceA(manchester_city, inglaterra).
perteneceA(bayern_munich, alemania).
perteneceA(paris_saint_germain, francia).
perteneceA(benfica, portugal).
perteneceA(sevilla, espana).
perteneceA(feyenoord, holanda).
perteneceA(real_madrid, espana).
perteneceA(manchester_united, inglaterra).
perteneceA(inter_milan, italia).
perteneceA(borussia_dortmund, alemania).
perteneceA(atletico_de_madrid, espana).
perteneceA(leipzig, alemania).
perteneceA(porto, portugal).
perteneceA(arsenal, inglaterra).
perteneceA(salzburgo, austria).
perteneceA(milan, italia).
perteneceA(lazio, italia).
perteneceA(estrella_roja, serbia).
perteneceA(sporting_braga, portugal).
perteneceA(psv_eindhoven, holanda).
perteneceA(copenhague, dinamarca).
perteneceA(shakhtar_donetsk, ucrania).
perteneceA(union_berlin, alemania).
perteneceA(lens, francia).
perteneceA(newcastle, inglaterra).
perteneceA(galatasaray, turquia).
perteneceA(real_sociedad, espana).
perteneceA(young_boys, suiza).
perteneceA(celtic_glasgow, escocia).
perteneceA(royal_antwerp, belgica).

enBombo(barcelona, 1).
enBombo(napoles, 1).
enBombo(manchester_city , 1).
enBombo(bayern_munich , 1).
enBombo(paris_saint_germain , 1).
enBombo(benfica , 1).
enBombo(sevilla , 1).
enBombo(feyenoord , 1).
enBombo(real_madrid, 2).
enBombo(manchester_united, 2).
enBombo(inter_milan, 2).
enBombo(borussia_dortmund, 2).
enBombo(atletico_de_madrid, 2).
enBombo(leipzig, 2).
enBombo(arsenal, 2).
enBombo(porto, 2).
enBombo(shakthar_donetsk, 3).
enBombo(salzburgo, 3).
enBombo(milan, 3).
enBombo(lazio, 3).
enBombo(estrella_roja, 3).
enBombo(sporting_braga, 3).
enBombo(psv_eindhoven, 3).
enBombo(copenhague, 3).
enBombo(union_berlin, 4).
enBombo(lens, 4).
enBombo(newcastle, 4).
enBombo(galatasaray, 4).
enBombo(real_sociedad, 4).
enBombo(young_boys, 4).
enBombo(celtic_glasgow, 4).
enBombo(royal_antwerp, 4).










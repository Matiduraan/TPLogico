% 1)

% BASE DE CONOCIMIENTOS

% provincia(Nombre,CantidadDeHabitantes).

provincia(buenosAires, 15355000).
provincia(chaco,1143201).
provincia(tierraDelFuego, 160720).
provincia(sanLuis, 489255).
provincia(neuquen,637913).
provincia(santaFe, 3397532).
provincia(cordoba, 3567654).
provincia(chubut, 577466).
provincia(formosa, 527895).
provincia(tucuman, 1687305).
provincia(salta, 1333365).
provincia(santaCruz, 273964).
provincia(laPampa, 349299).
provincia(corrientes, 992595).
provincia(misiones, 1189446).

% partido(Color,provincia).

partido(rojo, buenosAires).
partido(rojo, santaFe).
partido(rojo, cordoba). 
partido(rojo, chubut).
partido(rojo, tierraDelFuego).
partido(rojo, sanLuis).
partido(azul, buenosAires).
partido(azul, tierraDelFuego).
partido(azul, sanLuis).
partido(azul, neuquen).
partido(azul, chaco).
partido(amarillo, chaco ).
partido(amarillo, formosa ).
partido(amarillo, tucuman).
partido(amarillo, salta).
partido(amarillo, santaCruz).
partido(amarillo, laPampa).
partido(amarillo, corrientes).
partido(amarillo, misiones).
partido(amarillo, buenosAires).


% candidato(Nombre,Edad,partido).

candidato(frank,50,rojo).
candidato(claire,52,rojo).
candidato(catherine,59,rojo).
candidato(garret,64,azul).
candidato(linda,30,azul).
candidato(jackie,38,amarillo).
/*candidato(seth,_,amarillo).*/
candidato(heather,51,amarillo).

% 2)

% esPicante/1

% al menos dos partidos presentan candidatos en dicha provincia y esa provincia tiene > 1 millon habitantes

esPicante(Provincia):-
    provincia(Provincia,CantidadDeHabitantes),
    CantidadDeHabitantes > 1000000,
    partido(Color,Provincia),
    partido(OtroColor,Provincia),
    Color \= OtroColor. 


% 3)

% intencionDeVotoEn(Provincia, Partido, Porcentaje)

intencionDeVotoEn(buenosAires, rojo, 40).
intencionDeVotoEn(buenosAires, azul, 30).
intencionDeVotoEn(buenosAires, amarillo, 30).
intencionDeVotoEn(chaco, rojo, 50).
intencionDeVotoEn(chaco, azul, 20).
intencionDeVotoEn(chaco, amarillo, 0).
intencionDeVotoEn(tierraDelFuego, rojo, 40).
intencionDeVotoEn(tierraDelFuego, azul, 20).
intencionDeVotoEn(tierraDelFuego, amarillo, 10).
intencionDeVotoEn(sanLuis, rojo, 50).
intencionDeVotoEn(sanLuis, azul, 20).
intencionDeVotoEn(sanLuis, amarillo, 0).
intencionDeVotoEn(neuquen, rojo, 80).
intencionDeVotoEn(neuquen, azul, 10).
intencionDeVotoEn(neuquen, amarillo, 0).
intencionDeVotoEn(santaFe, rojo, 20).
intencionDeVotoEn(santaFe, azul, 40).
intencionDeVotoEn(santaFe, amarillo, 40).
intencionDeVotoEn(cordoba, rojo, 10).
intencionDeVotoEn(cordoba, azul, 60).
intencionDeVotoEn(cordoba, amarillo, 20).
intencionDeVotoEn(chubut, rojo, 15).
intencionDeVotoEn(chubut, azul, 15).
intencionDeVotoEn(chubut, amarillo, 15).
intencionDeVotoEn(formosa, rojo, 0).
intencionDeVotoEn(formosa, azul, 0).
intencionDeVotoEn(formosa, amarillo, 0).
intencionDeVotoEn(tucuman, rojo, 40).
intencionDeVotoEn(tucuman, azul, 40).
intencionDeVotoEn(tucuman, amarillo, 20).
intencionDeVotoEn(salta, rojo, 30).
intencionDeVotoEn(salta, azul, 60).
intencionDeVotoEn(salta, amarillo, 10).
intencionDeVotoEn(santaCruz, rojo, 10).
intencionDeVotoEn(santaCruz, azul, 20).
intencionDeVotoEn(santaCruz, amarillo, 30).
intencionDeVotoEn(laPampa, rojo, 25).
intencionDeVotoEn(laPampa, azul, 25).
intencionDeVotoEn(laPampa, amarillo, 40).
intencionDeVotoEn(corrientes, rojo, 30).
intencionDeVotoEn(corrientes, azul, 30).
intencionDeVotoEn(corrientes, amarillo, 10).
intencionDeVotoEn(misiones, rojo, 90).
intencionDeVotoEn(misiones, azul, 0).
intencionDeVotoEn(misiones, amarillo, 0).

% leGanaA/3

% El partido del ganador debe competir en la provincia.

% Si el partido del perdedor también compite en la provincia, se evalúa el que
% tenga el mayor porcentaje de votos en la provincia. Si hay empate, no se
% cumple la relación.

% Si ambos candidatos pertenecen al mismo partido, la relación se cumple si el
% partido compite en la provincia.

compiteEnLaProvincia(Candidato, Provincia):-
    candidato(Candidato,_,Partido),
    partido(Partido,Provincia).

leGanaPorCompetirEnLaProvincia(Candidato1,Candidato2,Provincia):-
    compiteEnLaProvincia(Candidato1,Provincia),
    not(compiteEnLaProvincia(Candidato2,Provincia)).

mayorPorcentaje(Candidato,Provincia):-
    compiteEnLaProvincia(Candidato, Provincia),
    intencionDeVotoEn(Provincia,Partido1,Porcentaje1),
    intencionDeVotoEn(Provincia,Partido2,Porcentaje2),
    Partido1 \= Partido2,
    Porcentaje1 > Porcentaje2.

leGanaPorTenerMayorPorcentaje(Candidato1,Candidato2,Provincia):-
    mayorPorcentaje(Candidato1,Provincia),
    not(mayorPorcentaje(Candidato2,Provincia)).

leGanaA(Candidato1,Candidato2,Provincia):-
    leGanaPorCompetirEnLaProvincia(Candidato1,Candidato2,Provincia).

leGanaA(Candidato1,Candidato2,Provincia):-
    leGanaPorTenerMayorPorcentaje(Candidato1,Candidato2,Provincia).

leGanaA(Candidato1,Candidato2,Provincia):-
    candidato(Candidato1,_,Partido),
    candidato(Candidato2,_,Partido),
    Candidato1 \= Candidato2,
    compiteEnLaProvincia(Candidato1,Provincia),
    compiteEnLaProvincia(Candidato2,Provincia).


% 4)

% elGranCandidato/1

% Para todas las provincias en las cuales su partido compite, el mismo gana.
% Es el candidato más joven de su partido.


esMasJoven(Candidato1,Candidato2):-
    candidato(Candidato1,Edad1,_),
    candidato(Candidato2,Edad2,_),
    Edad1 =< Edad2.

esElMasJovenDelPartido(Candidato):-
    candidato(Candidato,_,Partido),
    forall(candidato(Candidato2,_,Partido), esMasJoven(Candidato,Candidato2)).
    
ganaEnTodasLasProvincias(Candidato):-
    candidato(Candidato,_,Partido),
    forall(partido(Partido, Provincia), partidoGanadorEnLaProvincia(Partido,Provincia)).

partidoGanadorEnLaProvincia(Partido,Provincia):-
    partido(Partido,Provincia),
    forall(partido(OtrosPartidos,Provincia), ganaEnLaProvincia(Partido,OtrosPartidos,Provincia)).

ganaEnLaProvincia(Partido1,Partido2,Provincia):-
    intencionDeVotoEn(Provincia,Partido1,Porcentaje1),
    intencionDeVotoEn(Provincia,Partido2,Porcentaje2),
    Porcentaje1 > Porcentaje2.
    
elGranCandidato(Candidato):-
    esElMasJovenDelPartido(Candidato),
    ganaEnTodasLasProvincias(Candidato).

% 5)

ajusteConsultora(Partido,Provincia):-
    partidoGanadorEnLaProvincia(Partido,Provincia),
    intencionDeVotoEn(Provincia,Partido,CantidadDeVotos),
    CantidadDeVotos is CantidadDeVotos + 20.


ajusteConsultora(Partido,Provincia):-
    not(partidoGanadorEnLaProvincia(Partido,Provincia)),
    intencionDeVotoEn(Provincia,Partido,CantidadDeVotos),
    CantidadDeVotos is CantidadDeVotos - 5.

// Agent Player in project CuatroEnRaya.mas2j



/* Initial beliefs and rules */

//gana(Player):-



//Comprueba si hay una ficha del mismo jugador a la derecha de la indicada, 
//sin rebasar el limite del tablero
fichaDer(Player, Colu, Fila) :- 
	not Colu == 7 & comprobarPosicion(Player, Colu+1, Fila).
	
fichaIzq(Player, Colu, Fila) :- 
	not Colu == 0 & comprobarPosicion(Player, Colu-1, Fila).

fichaArr(Player, Colu, Fila) :- 
	not Fila == 0 & comprobarPosicion(Player, Colu, Fila-1).
	
fichaAba(Player, Colu, Fila) :- 
	not Fila == 7 & comprobarPosicion(Player, Colu, Fila+1).

//Diagonales
fichaDiaAbaDer(Player, Colu, Fila) :- 
	not Colu == 7 & not Fila == 7 & comprobarPosicion(Player, Colu+1, Fila+1).
	
fichaDiaAbaIzq(Player, Colu, Fila) :- 
	not Colu == 0 & not Fila == 7 & comprobarPosicion(Player, Colu-1, Fila+1).
	
fichaDiaArrDer(Player, Colu, Fila) :- 
	not Colu == 7 & not Fila == 0 & comprobarPosicion(Player, Colu+1, Fila-1).
	
fichaDiaArrIzq(Player, Colu, Fila) :- 
	not Colu == 0 & not Fila == 0 & comprobarPosicion(Player, Colu-1, Fila-1).

//comprobarPosicion(Player, Col, Fil):- tablero(Col, Fil, Player).
comprobarPosicion(Player, Col, Fil):- comprobar(Col, Fil, Player).


/*comprobar3enRaya(Player, Col, Fil, [Der,Izq]) :- 
	comprobarPosicion(Player, Col, Fil) &
	fichasConsecDer(Player, Col, Fil, 2, Der) & 
	fichasConsecIzq(Player, Col, Fil, 2, Izq).*/
	
comprobar3enRaya(Player, Col, Fil, Lista) :- 
	comprobarPosicion(Player, Col, Fil) &
	(fichasConsecDer(Player, Col, Fil, 2, Der) | Der = [])&
	(fichasConsecIzq(Player, Col, Fil, 2, Izq) | Izq = []) &
	(fichasConsecArr(Player, Col, Fil, 2, Arr) | Arr = []) &
	(fichasConsecAba(Player, Col, Fil, 2, Aba) | Aba = []) &
	(fichasConsecDiaArrDer(Player, Col, Fil, 2, DiaArrDer) | DiaArrDer = []) &
	(fichasConsecDiaAbaIzq(Player, Col, Fil, 2, DiaAbaIzq) | DiaAbaIzq = []) &
	(fichasConsecDiaArrIzq(Player, Col, Fil, 2, DiaArrIzq) | DiaArrIzq = []) &
	(fichasConsecDiaAbaDer(Player, Col, Fil, 2, DiaAbaDer) | DiaAbaDer = []) &
	.concat(Der, Izq, Arr, Aba, DiaArrDer, DiaAbaIzq, DiaArrIzq, DiaAbaDer, Lista).

comprobar2enRaya(Player, Col, Fil, Lista) :- 
	comprobarPosicion(Player, Col, Fil) &
	(fichasConsecDer(Player, Col, Fil, 1, Der) | Der = [])&
	(fichasConsecIzq(Player, Col, Fil, 1, Izq) | Izq = []) &
	(fichasConsecArr(Player, Col, Fil, 1, Arr) | Arr = []) &
	(fichasConsecAba(Player, Col, Fil, 1, Aba) | Aba = []) &
	(fichasConsecDiaArrDer(Player, Col, Fil, 1, DiaArrDer) | DiaArrDer = []) &
	(fichasConsecDiaAbaIzq(Player, Col, Fil, 1, DiaAbaIzq) | DiaAbaIzq = []) &
	(fichasConsecDiaArrIzq(Player, Col, Fil, 1, DiaArrIzq) | DiaArrIzq = []) &
	(fichasConsecDiaAbaDer(Player, Col, Fil, 1, DiaAbaDer) | DiaAbaDer = []) &
	.concat(Der, Izq, Arr, Aba, DiaArrDer, DiaAbaIzq, DiaArrIzq, DiaAbaDer, Lista).
	
//fichasConsecutivas(Jugador, Col, Fil, Numero de posicion a buscar consecutivamente, Lista de posiciones vacias)	
//Derecha
fichasConsecDer(Player, Col, Fil, Num, [[Col+1, Fil]]) :- fichaDer(0, Col, Fil) & Num == 0.
fichasConsecDer(Player, Col, Fil, Num, [[Col-1, Fil]|L]) :- fichaDer(Player, Col, Fil) & fichasConsecDer(Player, Col+1, Fil, Num-1, L) & fichaIzq(0, Col, Fil).
fichasConsecDer(Player, Col, Fil, Num, L) :- fichaDer(Player, Col, Fil) & fichasConsecDer(Player, Col+1, Fil, Num-1, L).
fichasConsecDer(Player, Col, Fil, Num, []) :- Num == 0.

//Izquierda
fichasConsecIzq(Player, Col, Fil, Num, [[Col-1, Fil]]) :- fichaIzq(0, Col, Fil) & Num == 0.
fichasConsecIzq(Player, Col, Fil, Num, [[Col+1, Fil]|L]) :- fichaIzq(Player, Col, Fil) & fichasConsecIzq(Player, Col-1, Fil, Num-1, L) & fichaDer(0, Col, Fil).
fichasConsecIzq(Player, Col, Fil, Num, L) :- fichaIzq(Player, Col, Fil) & fichasConsecIzq(Player, Col-1, Fil, Num-1, L).
fichasConsecIzq(Player, Col, Fil, Num, []) :- Num == 0.

//Arriba
fichasConsecArr(Player, Col, Fil, Num, [[Col, Fil-1]]) :- fichaArr(0, Col, Fil) & Num == 0.
fichasConsecArr(Player, Col, Fil, Num, [[Col, Fil+1]|L]) :- fichaArr(Player, Col, Fil) & fichasConsecArr(Player, Col, Fil-1, Num-1, L) & fichaAba(0, Col, Fil).
fichasConsecArr(Player, Col, Fil, Num, L) :- fichaArr(Player, Col, Fil) & fichasConsecArr(Player, Col, Fil-1, Num-1, L).
fichasConsecArr(Player, Col, Fil, Num, []) :- Num == 0.

//Abajo
fichasConsecAba(Player, Col, Fil, Num, [[Col, Fil+1]]) :- fichaAba(0, Col, Fil) & Num == 0.
fichasConsecAba(Player, Col, Fil, Num, [[Col, Fil-1]|L]) :- fichaAba(Player, Col, Fil) & fichasConsecAba(Player, Col, Fil+1, Num-1, L) & fichaArr(0, Col, Fil).
fichasConsecAba(Player, Col, Fil, Num, L) :- fichaAba(Player, Col, Fil) & fichasConsecAba(Player, Col, Fil+1, Num-1, L).
fichasConsecAba(Player, Col, Fil, Num, []) :- Num == 0.

//DiagonalArribaDerecha
fichasConsecDiaArrDer(Player, Col, Fil, Num, [[Col+1, Fil-1]]) :- fichaDiaArrDer(0, Col, Fil) & Num == 0.
fichasConsecDiaArrDer(Player, Col, Fil, Num, [[Col-1, Fil+1]|L]) :- fichaDiaArrDer(Player, Col, Fil) & fichasConsecDiaArrDer(Player, Col+1, Fil-1, Num-1, L) & fichaDiaAbaIzq(0, Col, Fil).
fichasConsecDiaArrDer(Player, Col, Fil, Num, L) :- fichaDiaArrDer(Player, Col, Fil) & fichasConsecDiaArrDer(Player, Col+1, Fil-1, Num-1, L).
fichasConsecDiaArrDer(Player, Col, Fil, Num, []) :- Num == 0.

//DiagonalAbajoIzquierda
fichasConsecDiaAbaIzq(Player, Col, Fil, Num, [[Col-1, Fil+1]]) :- fichaDiaAbaIzq(0, Col, Fil) & Num == 0.
fichasConsecDiaAbaIzq(Player, Col, Fil, Num, [[Col+1, Fil-1]|L]) :- fichaDiaAbaIzq(Player, Col, Fil) & fichasConsecDiaAbaIzq(Player, Col-1, Fil+1, Num-1, L) & fichaDiaArrDer(0, Col, Fil).
fichasConsecDiaAbaIzq(Player, Col, Fil, Num, L) :- fichaDiaAbaIzq(Player, Col, Fil) & fichasConsecDiaAbaIzq(Player, Col-1, Fil+1, Num-1, L).
fichasConsecDiaAbaIzq(Player, Col, Fil, Num, []) :- Num == 0.

//DiagonalArribaIzquierda
fichasConsecDiaArrIzq(Player, Col, Fil, Num, [[Col-1, Fil-1]]) :- fichaDiaArrIzq(0, Col, Fil) & Num == 0.
fichasConsecDiaArrIzq(Player, Col, Fil, Num, [[Col+1, Fil+1]|L]) :- fichaDiaArrIzq(Player, Col, Fil) & fichasConsecDiaArrIzq(Player, Col-1, Fil-1, Num-1, L) & fichaDiaAbaDer(0, Col, Fil).
fichasConsecDiaArrIzq(Player, Col, Fil, Num, L) :- fichaDiaArrIzq(Player, Col, Fil) & fichasConsecDiaArrIzq(Player, Col-1, Fil-1, Num-1, L).
fichasConsecDiaArrIzq(Player, Col, Fil, Num, []) :- Num == 0.

//DiagonalAbajoDerecha
fichasConsecDiaAbaDer(Player, Col, Fil, Num, [[Col+1, Fil+1]]) :- fichaDiaAbaDer(0, Col, Fil) & Num == 0.
fichasConsecDiaAbaDer(Player, Col, Fil, Num, [[Col-1, Fil-1]|L]) :- fichaDiaAbaDer(Player, Col, Fil) & fichasConsecDiaAbaDer(Player, Col+1, Fil+1, Num-1, L) & fichaDiaArrIzq(0, Col, Fil).
fichasConsecDiaAbaDer(Player, Col, Fil, Num, L) :- fichaDiaAbaDer(Player, Col, Fil) & fichasConsecDiaAbaDer(Player, Col+1, Fil+1, Num-1, L).
fichasConsecDiaAbaDer(Player, Col, Fil, Num, []) :- Num == 0.

//Comprobar 2-1

comprobar21(Player, X, [], []).

comprobar21(Player, X, [], L).
		
//Horizontal
comprobar21(Player, [M,N], [[X,Y]|Cdr], [[X,Y]|L]) :- 
		N==Y & M>X & fichaIzq(Player, X, Y) 
		& comprobar21(Player, [M,N], Cdr, L).

comprobar21(Player, [M,N], [[X,Y]|Cdr], [[X,Y]|L]) :- 
		N==Y & M<X & fichaDer(Player, X, Y)
		& comprobar21(Player, [M,N], Cdr, L).

//Vertical
comprobar21(Player, [M,N], [[X,Y]|Cdr], [[X,Y]|L]) :- 
		N>Y & M==X & fichaArr(Player, X, Y)
		& comprobar21(Player, [M,N], Cdr, L).

comprobar21(Player, [M,N], [[X,Y]|Cdr], [[X,Y]|L]) :- 
		N<Y & M==X & fichaAba(Player, X, Y)
		& comprobar21(Player, [M,N], Cdr, L).	
		
//Diagonal derecha
comprobar21(Player, [M,N], [[X,Y]|Cdr], [[X,Y]|L]) :- 
		N>Y & M>X & fichaDiaArrIzq(Player, X, Y)
		& comprobar21(Player, [M,N], Cdr, L).
		
comprobar21(Player, [M,N], [[X,Y]|Cdr], [[X,Y]|L]) :- 
		N<Y & M<X & fichaDiaAbaDer(Player, X, Y)
		& comprobar21(Player, [M,N], Cdr, L).		
		
//Diagonal izquierda
comprobar21(Player, [M,N], [[X,Y]|Cdr], [[X,Y]|L]) :- 
		N>Y & M<X & fichaDiaArrDer(Player, X, Y)
		& comprobar21(Player, [M,N], Cdr, L).
		
comprobar21(Player, [M,N], [[X,Y]|Cdr], [[X,Y]|L]) :- 
		N<Y & M>X & fichaDiaAbaIzq(Player, X, Y)
		& comprobar21(Player, [M,N], Cdr, L).	

comprobar21(Player, [M,N], [Car|Cdr], L) :- comprobar21(Player, [M,N], Cdr, L).

comprobar2_21(Player, Col, Fil, L) :- 
	comprobar2enRaya(Player,Col,Fil,X) &
	comprobar21(Player, [Col,Fil], X, L).
	
//Secciones
seccionA(X,Y) :- X>=0 & X<4 & Y>=0 & Y<4.
seccionB(X,Y) :- X>=0 & X<4 & Y>=4 & Y<8.
seccionC(X,Y) :- X>=4 & X<8 & Y>=0 & Y<4.
seccionD(X,Y) :- X>=4 & X<8 & Y>=4 & Y<8.

//Libre1Libre1Libre

//Horizontal
libre1libre1libre(Player, [X,Y], [X+1,Y]) :- 
	fichaIzq(0, X, Y) & fichaDer(0, X, Y)
	& fichaDer(Player, X+1, Y)
	& fichaDer(0, X+2, Y).
		
//Vertical
libre1libre1libre(Player, [X,Y], [X,Y+1]) :- 
	fichaArr(0, X, Y) & fichaAba(0, X, Y)
	& fichaAba(Player, X, Y+1)
	& fichaAba(0, X, Y+2).
		 
//Diagonal Izquierda
libre1libre1libre(Player, [X,Y], [X+1,Y-1]) :- 
	fichaDiaAbaIzq(0, X, Y) & fichaDiaArrDer(0, X, Y)
	& fichaDiaArrDer(Player, X+1, Y-1)
	& fichaDiaArrDer(0, X-2, Y+2).

//Diagonal Derecha
libre1libre1libre(Player, [X,Y], [X+1,Y+1]) :- 
	fichaDiaArrIzq(0, X, Y) & fichaDiaAbaDer(0, X, Y)
	& fichaDiaAbaDer(Player, X+1, Y+1)
	& fichaDiaAbaDer(0, X+2, Y+2).	

//Hipótesis 3

sepuede3enRaya(Player, Col, Fil) :- 
	comprobarPosicion(Player, Col, Fil) &
	(fichasConsecDer(Player, Col, Fil, 2, Der) & .length(Der, 2)) |
	(fichasConsecIzq(Player, Col, Fil, 2, Izq) & .length(Izq, 2)) |
	(fichasConsecArr(Player, Col, Fil, 2, Arr) & .length(Arr, 2)) |
	(fichasConsecAba(Player, Col, Fil, 2, Aba) & .length(Aba, 2)) |
	(fichasConsecDiaArrDer(Player, Col, Fil, 2, DiaArrDer) & .length(DiaArrDer,2)) |
	(fichasConsecDiaAbaIzq(Player, Col, Fil, 2, DiaAbaIzq) & .length(DiaAbaIzq,2)) |
	(fichasConsecDiaArrIzq(Player, Col, Fil, 2, DiaArrIzq) & .length(DiaArrIzq,2)) |
	(fichasConsecDiaAbaDer(Player, Col, Fil, 2, DiaAbaDer) & .length(DiaAbaDer,2)).
	
/* Initial goals */

!pruebas.
//!turno(0).
//!concat.
/* Plans */
//Para evitar problemas con los nombres
//+!jugador: turno(Name) <- +miNombre(Name); !turno(0).
//+!jugador <- !jugador.

+!pruebas <- !estados; !prueba.
+!concat <- L=[1,2,3]; R = [];.concat([L],[R],X);.length(X,N);.print(N).
+!estados <- +comprobar(0,0,0); +comprobar(1,0,0); +comprobar(2,0,0); +comprobar(3,0,0); +comprobar(4,0,0); +comprobar(5,0,0); +comprobar(6,0,0); +comprobar(7,0,0);
			 +comprobar(0,1,0); +comprobar(1,1,0); +comprobar(2,1,0); +comprobar(3,1,0); +comprobar(4,1,0); +comprobar(5,1,0); +comprobar(6,1,0); +comprobar(7,1,0);
			 +comprobar(0,2,0); +comprobar(1,2,0); +comprobar(2,2,0); +comprobar(3,2,0); +comprobar(4,2,0); +comprobar(5,2,0); +comprobar(6,2,1); +comprobar(7,2,0);
			 +comprobar(0,3,0); +comprobar(1,3,0); +comprobar(2,3,0); +comprobar(3,3,1); +comprobar(4,3,1); +comprobar(5,3,0); +comprobar(6,3,2); +comprobar(7,3,0);
			 +comprobar(0,4,0); +comprobar(1,4,0); +comprobar(2,4,0); +comprobar(3,4,0); +comprobar(4,4,0); +comprobar(5,4,0); +comprobar(6,4,0); +comprobar(7,4,0);
			 +comprobar(0,5,0); +comprobar(1,5,0); +comprobar(2,5,0); +comprobar(3,5,0); +comprobar(4,5,0); +comprobar(5,5,0); +comprobar(6,5,0); +comprobar(7,5,0);
			 +comprobar(0,6,0); +comprobar(1,6,0); +comprobar(2,6,0); +comprobar(3,6,0); +comprobar(4,6,0); +comprobar(5,6,0); +comprobar(6,6,0); +comprobar(7,6,0);
			 +comprobar(0,7,0); +comprobar(1,7,0); +comprobar(2,7,0); +comprobar(3,7,0); +comprobar(4,7,0); +comprobar(5,7,0); +comprobar(6,7,0); +comprobar(7,7,0).

+!prueba: comprobar2enRaya(1,3,3,L)<- .print("True: ",L," - ",A," - ",B).
//+!prueba: /*comprobar2enRaya(1, 1, 2, X) & comprobar21(1, [1,2], X , L) */ comprobar2_21(1, 1, 2, X)<- .print("True: ",L," - ",X," - ",B).
//+!prueba: libre1libre1libre(1, [4,4], L) <- .print("True: ",L," - ",Y," - ",B).
+!prueba <- .print("False.").

+!turno(X): .my_name(Ag) & turno(Ag)<- .print("Entre!!",Ag); put(1,1+X); !turno(X+1).

+!turno(X): .my_name(Ag)<- .print("Esperando..", Ag);.wait(100); !turno(X).


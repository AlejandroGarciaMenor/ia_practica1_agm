# Inteligencia Artificial - Práctica 1 - Sorteo de Champions League

Se ha desarrollado un programa en Prolog que cumple dos tareas:

- Validación del sorteo de un grupo específico.
- Generación de un grupo aleatorio.

Se tendrán que cumplir las reglas de este sorteo, que impiden que se crucen equipos de un mismo país o equipos que estén en un mismo bombo.

## Instalación

- Clona este repositorio en el terminal.
```bash
git clone https://github.com/AlejandroGarciaMenor/ia_practica1_agm.git
```
- Abre SWI Prolog
```bash
swipl champions.pl
```
- Efectua el consult
```bash
?- consult('champions.pl').
```


## Utilización

```prolog

# Consulta de un grupo que no cumple con las condiciones de validez:
?- grupoValido([royal_antwerp, barcelona, union_berlin, arsenal]).
false.

# Consulta de un grupo que sí cumple con las condiciones de validez:
?- grupoValido([royal_antwerp, barcelona, estrella_roja, arsenal]).
true.

# Generación de un grupo de forma aleatoria
?- generarGrupo.
Grupo generado: [napoles,manchester_united,salzburgo,real_sociedad]
true .

```


## Licencia

Copyright [2023] [Alejandro García Menor]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

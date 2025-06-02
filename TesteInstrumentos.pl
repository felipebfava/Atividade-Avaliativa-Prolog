/* animais.pl - jogo de identifica��o de animais.

    inicia com ?- iniciar.     */

iniciar :- hipotese(Instrumento),
      write('Eu acho que o instrumento musical �: '),
      write(Instrumento),
      nl,
      undo.

/* hip�teses a serem testadas */
hipotese(guitarra)   :- guitarra, !.
hipotese(violao)   :- violao, !.
hipotese(cavaquinho)   :- cavaquinho, !.
hipotese(violino)     :- violino, !.
hipotese(viola)   :- viola, !.
hipotese(violoncelo)   :- violoncelo, !.
hipotese(bateria) :- bateria, !.
hipotese(pandeiro) :- pandeiro, !.
hipotese(tambor) :- tambor, !.
hipotese(piano) :- piano, !.
hipotese(desconhecido).             /* sem diagn�stico */

/* Regras de identifica��o dos animais */
guitarra :- beliscado,
           cordofone,
           verificar(tem_cor_castanho_claro_para_marrom_alaranjado),
           verificar(tem_manchas_escuras).
                   
violao :- beliscado,
         cordofone,
         verificar(tem_cor_castanho_claro_para_marrom_alaranjado),
         verificar(tem_listras_pretas).
                 
cavaquinho :- beliscado,
              cordofone,
              verificar(tem_pesco�o_longo),
              verificar(tem_pernas_longas).
                   
violino :- friccionado,
           cordofone,
           verificar(tem_listras_pretas).

viola :- friccionado,
         cordofone,
         verificar(n�o_voa),
         verificar(tem_pesco�o_longo).
                   
violoncelo :- friccionado,
              cordofone,
              verificar(n�o_voa),
              verificar(nada),
              verificar(�_preto_e_branco).
                   
bateria :- percutido,
           membranofone,
           verificar(aparece_no_conto_do_velho_marinheiro),
           verificar(voa_bem).

pandeiro :- percutido,
            membranofone,
            verificar(aparece_no_conto_do_velho_marinheiro),
            verificar(voa_bem).

tambor :- percutido,
          membranofone,
          verificar(aparece_no_conto_do_velho_marinheiro),
          verificar(voa_bem).

piano :- percutido,
         cordofone,
         verificar(aparece_no_conto_do_velho_marinheiro),
         verificar(voa_bem).

/* regras de classifica��o */
mam�fero    :- verificar(tem_cabelo), !.
mam�fero    :- verificar(d�_leite).

p�ssaro      :- verificar(tem_penas), !.
p�ssaro      :- verificar(voa),verificar(p�e_ovos).
                         
carn�voro :- verificar(come_carne), !.
carn�voro :- verificar(tem_dentes_pontudos),
             verificar(tem_garras),
             verificar(tem_olhos_frontais).
                         
ungulado :- mam�fero,verificar(tem_cascos), !.
ungulado :- mam�fero,verificar(rumina).

/* Como fazer perguntas */
perguntar(Quest�o) :-
    write('O instrumento musical tem o seguinte atributo: '),
    write(Quest�o),
    write(' (s|n) ? '),
    read(Resposta),
    nl,
    ( (Resposta == sim ; Resposta == s)
      ->
       assert(yes(Quest�o)) ;
       assert(no(Quest�o)), fail).

:- dynamic yes/1,no/1.

/*
(Condi��o -> A��o_se_verdadeira ; A��o_se_falsa)

(8 =:= 4*2? -> write("sim") ; write("n�o")).
*/

/* Como verificar algo */
verificar(S) :-
   (yes(S) % tem yes?
    ->
    true ;  % se sim: retorna true
    (no(S) % n�o tem yes. Verifica tem no?
     ->
     fail ; % se sim:  para o fluxo de execu��o
     perguntar(S)% se n�o tem yes e nem no, deve perguntar
    )
   ).

/* Desfaz todas as afirma��es sim / n�o */
undo :- retract(yes(_)),fail.
undo :- retract(no(_)),fail.
undo.

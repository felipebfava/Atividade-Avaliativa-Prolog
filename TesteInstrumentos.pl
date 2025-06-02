/* animais.pl - jogo de identificação de animais.

    inicia com ?- iniciar.     */

iniciar :- hipotese(Instrumento),
      write('Eu acho que o instrumento musical é: '),
      write(Instrumento),
      nl,
      undo.

/* hipóteses a serem testadas */
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
hipotese(desconhecido).             /* sem diagnóstico */

/* Regras de identificação dos animais */
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
              verificar(tem_pescoço_longo),
              verificar(tem_pernas_longas).
                   
violino :- friccionado,
           cordofone,
           verificar(tem_listras_pretas).

viola :- friccionado,
         cordofone,
         verificar(não_voa),
         verificar(tem_pescoço_longo).
                   
violoncelo :- friccionado,
              cordofone,
              verificar(não_voa),
              verificar(nada),
              verificar(é_preto_e_branco).
                   
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

/* regras de classificação */
mamífero    :- verificar(tem_cabelo), !.
mamífero    :- verificar(dá_leite).

pássaro      :- verificar(tem_penas), !.
pássaro      :- verificar(voa),verificar(põe_ovos).
                         
carnívoro :- verificar(come_carne), !.
carnívoro :- verificar(tem_dentes_pontudos),
             verificar(tem_garras),
             verificar(tem_olhos_frontais).
                         
ungulado :- mamífero,verificar(tem_cascos), !.
ungulado :- mamífero,verificar(rumina).

/* Como fazer perguntas */
perguntar(Questão) :-
    write('O instrumento musical tem o seguinte atributo: '),
    write(Questão),
    write(' (s|n) ? '),
    read(Resposta),
    nl,
    ( (Resposta == sim ; Resposta == s)
      ->
       assert(yes(Questão)) ;
       assert(no(Questão)), fail).

:- dynamic yes/1,no/1.

/*
(Condição -> Ação_se_verdadeira ; Ação_se_falsa)

(8 =:= 4*2? -> write("sim") ; write("não")).
*/

/* Como verificar algo */
verificar(S) :-
   (yes(S) % tem yes?
    ->
    true ;  % se sim: retorna true
    (no(S) % não tem yes. Verifica tem no?
     ->
     fail ; % se sim:  para o fluxo de execução
     perguntar(S)% se não tem yes e nem no, deve perguntar
    )
   ).

/* Desfaz todas as afirmações sim / não */
undo :- retract(yes(_)),fail.
undo :- retract(no(_)),fail.
undo.

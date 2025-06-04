/* InstrumentosMusicais.pl - jogo de identificação de instrumentos musicais.
    inicia com ?- iniciar.     */

:- dynamic yes/1, no/1.

iniciar :-
    hipotese(Instrumento),
    write('Eu acho que o instrumento musical é: '),
    write(Instrumento),
    nl,
    undo.

/* 10 hipóteses a serem testadas */
hipotese(guitarra)   :- guitarra, !.
hipotese(violao)     :- violao, !.
hipotese(cavaquinho) :- cavaquinho, !.
hipotese(violino)    :- violino, !.
hipotese(viola)      :- viola, !.
hipotese(violoncelo) :- violoncelo, !.
hipotese(bateria)    :- bateria, !.
hipotese(pandeiro)   :- pandeiro, !.
hipotese(tambor)     :- tambor, !.
hipotese(piano)      :- piano, !.
hipotese(desconhecido). /* sem diagnóstico */

/* Regras de identificação dos instrumentos */
/* Características de cada instrumento */
guitarra :-
    beliscado,
    cordofone,
    verificar(usa_palheta),
    verificar(pode_ser_tocada_sem_palheta),
    verificar(utilizada_em_diversos_generos),
    verificar(utilizada_em_generos_musicais_brasileiros),
    verificar(utilizada_em_musica_popular),
    verificar(utilizada_em_orquestras_modernas),
    verificar(tocada_apoiada_no_torax),
    verificar(tocada_apoiada_na_perna),
    verificar(peso_maior_que_2kg).

violao :-
    beliscado,
    cordofone,
    verificar(usa_palheta),
    verificar(pode_ser_tocada_sem_palheta),
    verificar(utilizada_em_generos_musicais_brasileiros),
    verificar(utilizada_em_musica_classica),
    verificar(utilizada_em_musica_popular),
    verificar(tocada_apoiada_na_perna),
    verificar(peso_entre_1kg_e_2kg).

cavaquinho :-
    beliscado,
    cordofone,
    verificar(usa_palheta),
    verificar(pode_ser_tocada_sem_palheta),
    verificar(utilizada_em_generos_musicais_brasileiros),
    verificar(utilizada_em_samba),
    verificar(utilizada_em_pagode),
    verificar(utilizada_em_forro),
    verificar(tocada_apoiada_no_torax),
    verificar(peso_menor_que_1kg).

violino :-
    friccionado,
    cordofone,
    verificar(usa_arco_vareta),
    verificar(pode_usar_tecnica_pizzicato),
    verificar(utilizada_em_musica_classica),
    verificar(tocado_apoiado_no_maxilar),
    verificar(peso_muito_leve).

viola :-
    friccionado,
    cordofone,
    verificar(usa_arco_vareta),
    verificar(pode_usar_tecnica_pizzicato),
    verificar(utilizada_em_generos_musicais_brasileiros),
    verificar(utilizada_em_musica_caipira),
    verificar(utilizada_em_sertanejo),
    verificar(utilizada_em_musica_classica),
    verificar(tocado_apoiado_no_maxilar),
    verificar(peso_leve).

violoncelo :-
    friccionado,
    cordofone,
    verificar(usa_arco_vareta),
    verificar(pode_usar_tecnica_pizzicato),
    verificar(utilizada_em_orquestras),
    verificar(utilizada_em_musica_classica),
    verificar(tocado_apoiado_entre_as_pernas),
    verificar(peso_medio_pesado).

bateria :-
    percutido,
    membranofone,
    verificar(usa_baquetas),
    verificar(tocado_com_maos),
    verificar(tocado_com_pes),
    verificar(utilizada_como_base_ritmica),
    verificar(utilizada_em_diversos_generos),
    verificar(utilizada_em_generos_musicais_brasileiros),
    verificar(utilizada_em_musica_popular),
    verificar(utilizada_em_orquestras_modernas),
    verificar(tocado_apoiado_num_banco),
    verificar(peso_muito_pesado).

pandeiro :-
    percutido,
    membranofone,
    verificar(tocado_com_maos),
    verificar(utilizada_em_generos_musicais_brasileiros),
    verificar(utilizada_em_samba),
    verificar(utilizada_em_pagode),
    verificar(utilizada_em_forro),
    verificar(tocado_apoiado_nas_maos),
    verificar(peso_leve).

tambor :-
    percutido,
    membranofone,
    verificar(usa_baquetas),
    verificar(tocado_com_maos),
    verificar(utilizada_como_base_ritmica),
    verificar(utilizada_em_musica_popular),
    verificar(utilizada_em_orquestras),
    verificar(tocado_apoiado_no_chao),
    verificar(peso_medio_pesado).

piano :-
    percutido,
    cordofone,
    verificar(tocado_com_teclas),
    verificar(tocado_com_maos),
    verificar(pode_usar_pedais),
    verificar(utilizada_em_diversos_generos),
    verificar(utilizada_em_generos_musicais_brasileiros),
    verificar(utilizada_em_musica_classica),
    verificar(utilizada_em_musica_popular),
    verificar(utilizada_em_orquestras),
    verificar(instrumento_muito_grande),
    verificar(peso_extremamente_pesado).

/* regras de classificação por categoria de som - cordofone ou membranofone */
cordofone :- verificar(som_produzido_por_cordas), !.
cordofone :- verificar(tem_cordas).

membranofone :- verificar(som_produzido_por_membrana), !.
membranofone :- verificar(tem_pele_ou_membrana).

/* regras de classificação pela técnica utilizada para reproduzir o som */
beliscado :- verificar(cordas_sao_pinçadas), !.
beliscado :- verificar(cordas_sao_dedilhadas).

friccionado :- verificar(cordas_sao_friccionadas), !.
friccionado :- verificar(usa_arco_para_tocar).

percutido :- verificar(som_produzido_batendo), !.
percutido :- verificar(som_produzido_golpeando).

/* Como fazer as perguntas */
perguntar(Questao) :-
    write('O instrumento tem o seguinte atributo: '),
    write(Questao),
    write('? (s/n) '),
    read(Resposta),
    nl,
    ( (Resposta == sim ; Resposta == s)
      ->
       assertz(yes(Questao)) ;
       assertz(no(Questao)), fail).

/* Como verificar algo */
verificar(S) :-
   (yes(S)
    ->
    true ;
    (no(S)
     ->
     fail ;
     perguntar(S)
    )
   ).

/* Desfaz todas as afirmações sim / não */
undo :- retract(yes(_)), fail.
undo :- retract(no(_)), fail.
undo.

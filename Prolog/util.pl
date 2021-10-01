:-style_check(-discontiguous).
:-style_check(-singleton).

% Ler um arquivo csv e retorna uma lista de lista.
lerArquivoCsv(Arquivo, Lists):-
    atom_concat('./dados/', Arquivo, Path),
    csv_read_file(Path, Rows, []),
    rows_to_lists(Rows, Lists).

rows_to_lists(Rows, Lists):- maplist(row_to_list, Rows, Lists).

row_to_list(Row, List):-
    Row =.. [row|List].

% Verifica se a variável "Busca" existe numa lista, retornando true ou false.
ehMember(_, [], false).
ehMember(Busca, [H|T], R):-
    (member(Busca, H) -> R = true ; ehMember(Busca, T, R)
    ).

%  Gera a lista que queremos excluir da lista de lista passada como parâmetro.
%  Exemplo: removegg(111, [[333, Nome, Placa], [111, Nome, Placa]]) -> [111, Nome, Placa]
removegg(_, [], []).
removegg(Cpf, [H|T], C):- (member(Cpf, H) -> C = H; removegg(Cpf, T, C)).

remove(X, [X|T], T).
remove(X, [H|T], [H|T1]):- remove(X,T,T1).

%  Escreve o cliente no arquivo csv.
cadastrarCliente(Cpf, Nome, Placa):-
    open('./dados/clientes.csv', append, Fluxo),
    writeln(Fluxo, (Cpf, Nome, Placa)),
    close(Fluxo).

%  Reescreve clientes.csv sem o cliente excluído.
reescreveCliente([]).
reescreveCliente([H|T]):-
    nth0(0, H, Cpf), % Indice 0
    nth0(1, H, Nome), % Indice 1
    nth0(2, H, Placa), % Indice 2
    cadastrarCliente(Cpf, Nome, Placa),
    reescreveCliente(T).
       
%  Limpa algum arquivo csv passado como parâmetro.
limpaCsv(Arquivo):-
    atom_concat('./dados/', Arquivo, Path),
    open(Path, write, Fluxo),
    write(Fluxo, ''),
    close(Fluxo).

%  Escreve o funcionário no arquivo csv.
cadastrarFuncionario(Cpf, Nome):-
    open('./dados/funcionarios.csv', append, Fluxo),
    writeln(Fluxo, (Cpf, Nome)),
    close(Fluxo).

%  Reescreve funcionarios.csv sem o cliente excluído.
reescreveFuncionario([]).
reescreveFuncionario([H|T]):-
    nth0(0, H, Cpf), % Indice 0
    nth0(1, H, Nome), % Indice 1
    cadastrarFuncionario(Cpf, Nome),
    reescreveFuncionario(T).

cadastrarCpv(Cpf, Placa, Vaga, Hora, Service):-
    open('./dados/cpvhs.csv', append, Fluxo),
    writeln(Fluxo, (Cpf, Placa, Vaga, Hora, Service)),
    close(Fluxo).

%  Reescreve CPF, Placa, Vaga, Hora, Service no arquivo Cpvhs.
reescreveCpvhs([]).
reescreveCpvhs([H|T]):-
    nth0(0, H, Cpf), % Indice 1
    nth0(1, H, Placa), % Indice 2
    nth0(2, H, Vaga), % Indice 3
    nth0(3, H, Hora), % Indice 4
    nth0(4, H, Service), % Indice 5
    cadastrarCpv(Cpf, Placa, Vaga, Hora, Service),
    reescreveCpvhs(T).

%  Aumenta 1 na quantidade de uso do contrato.
reescreveUsoContrato([], _).
reescreveUsoContrato([H|T], Busca):-
    nth0(0, H, Cpf), % Indice 1
    nth0(1, H, Qntd), % Indice 2
    (Busca =:= Cpf -> NewQntd is Qntd + 1 ; NewQntd = Qntd),
    cadastrarUsoDoContrato(Cpf, NewQntd),
    reescreveUsoContrato(T, Busca).

%  Zera a quantidade de uso do contrato do cliente.
reescreveRenovacao([], _).
reescreveRenovacao([H|T], Busca):-
    nth0(0, H, Cpf), % Indice 1
    nth0(1, H, Qntd), % Indice 2
    nth0(2, H, Tipo), % Indice 3
    (Busca =:= Cpf -> NewQntd = 0 ; NewQntd = Qntd),
    cadastrarUsoDoContrato(Cpf, NewQntd, Tipo),
    reescreveRenovacao(T, Busca).

cadastrarUsoDoContrato(Cpf, Qntd, Tipo):-
    open('./dados/usoDoContrato.csv', append, Fluxo),
    writeln(Fluxo, (Cpf, Qntd, Tipo)),
    close(Fluxo).

cadastrarContrato(Cpf, Nome, Placa, Vaga, Tipo):-
    open('./dados/contratos.csv', append, Fluxo),
    writeln(Fluxo, (Cpf, Nome, Placa, Vaga, Tipo)),
    close(Fluxo).

cadastrarVaga(Vaga):-
    open('./dados/vagas.csv', append, Fluxo),
    writeln(Fluxo, (Vaga)),
    close(Fluxo).

%  Reescreve a vaga ocupado pelo cliente no arquivo de vagas.
reescreveVaga([]).
reescreveVaga([H|T]):-
    nth0(0, H, Vaga), % Indice 0
    cadastrarVaga(Vaga),
    reescreveVaga(T).


%  Exclui a vaga escolhida pelo cliente do arquivo csv.
opcaoVaga(Vaga):-
    lerArquivoCsv('vagas.csv', Result),
    
    removegg(Vaga, Result, X),
    remove(X, Result, VagasExc),
    
    limpaCsv('vagas.csv'),
    
    reescreveVaga(VagasExc).

%  Verifica se o contrato semanal/mensal venceu.
renovacaoDeContrato(Lista):-
    nth0(1, Lista, Qntd),
    nth0(2, Lista, Tipo),
    
    (Tipo == 's', Qntd =:= 7  -> true ; (Tipo == 'm', Qntd =:= 30 -> true ; false)).

%  Exclui cliente do usoDoContrato.csv
excluirUsoDoContrato(Cpf, Result):-
    removegg(Cpf, Result, X),
    remove(X, Result, ContratosExc),
    limpaCsv('usoDoContrato.csv'),
    reescreveContrato(ContratosExc).

reescreveContrato([]).
reescreveContrato([H|T]):-
    nth0(0, H, Cpf), % Indice 1
    nth0(1, H, Qntd), % Indice 2
    nth0(2, H, Tipo), % Indice 3
    cadastrarUsoDoContrato(Cpf, Qntd, Tipo),
    reescreveContrato(T).

%  Exclui cliente do contratos.csv
excluirContratos(Cpf2, Result2):-
    removegg(Cpf2, Result2, X2),
    remove(X2, Result2, ContratosExc2),
    limpaCsv('contratos.csv'),
    reescreveContrato2(ContratosExc2).

reescreveContrato2([]).
reescreveContrato2([H|T]):-
    nth0(0, H, Cpf), % Indice 1
    nth0(1, H, Nome), % Indice 2
    nth0(2, H, Placa), % Indice 3
    nth0(3, H, Vaga), % Indice 3
    nth0(4, H, Tipo), % Indice 3
    cadastrarContrato(Cpf, Nome, Placa, Vaga, Tipo),
    reescreveContrato2(T).

%  Retorna o maior elemento de uma lista.
maior_lista([R],R).
maior_lista([C|L],R) :- maior_lista(L,A), (A > C -> R = A; R = C).

%  Corta uma lista a partir do índice passado como parâmetro.
geraL(_, 11, []).
geraL(L, I, [H|T]):- 
    nth0(I, L, El),
    H = El,
    NewI is I+1,
    geraL(L, NewI, T).

%  Retorna o índice do maior elemento passado como parâmetro.
pegaIndice(L, I, Maior, R):-
    nth0(I, L, P),
    (Maior =:= P -> R = I, !; NewI is I+1, pegaIndice(L, NewI, Maior, R)).


cadastrarRecomendacao(Cpf, NewI1, NewI2, NewI3, NewI4, NewI5, NewI6, NewI7, NewI8, NewI9, NewI10):-
    open('./dados/recomendacao.csv', append, Fluxo),
    writeln(Fluxo, (Cpf, NewI1, NewI2, NewI3, NewI4, NewI5, NewI6, NewI7, NewI8, NewI9, NewI10)),
    close(Fluxo).

reescreveRecomendacao([], _, _).
reescreveRecomendacao([H|T], I, Busca):-
    NewI = I,
    nth0(0, H, Cpf), % Indice 1
    nth0(1, H, I1), % Indice 2
    (1 =:= NewI -> (Cpf =:= Busca -> NewI1 is I1 + 1 ; NewI1 = I1) ; NewI1 = I1),
    nth0(2, H, I2), % Indice 3
    (2 =:= NewI -> (Cpf =:= Busca -> NewI2 is I2 + 1 ; NewI2 = I2) ; NewI2 = I2),
    nth0(3, H, I3), % Indice 3
    (3 =:= NewI -> (Cpf =:= Busca -> NewI3 is I3 + 1 ; NewI3 = I3) ; NewI3 = I3),
    nth0(4, H, I4), % Indice 3
    (4 =:= NewI -> (Cpf =:= Busca -> NewI4 is I4 + 1 ; NewI4 = I4) ; NewI4 = I4),
    nth0(5, H, I5), % Indice 3
    (5 =:= NewI -> (Cpf =:= Busca -> NewI5 is I5 + 1 ; NewI5 = I5) ; NewI5 = I5),
    nth0(6, H, I6), % Indice 3
    (6 =:= NewI -> (Cpf =:= Busca -> NewI6 is I6 + 1 ; NewI6 = I6) ; NewI6 = I6),
    nth0(7, H, I7), % Indice 3
    (7 =:= NewI -> (Cpf =:= Busca -> NewI7 is I7 + 1 ; NewI7 = I7) ; NewI7 = I7),
    nth0(8, H, I8), % Indice 3
    (8 =:= NewI -> (Cpf =:= Busca -> NewI8 is I8 + 1 ; NewI8 = I8) ; NewI8 = I8),
    nth0(9, H, I9), % Indice 3
    (9 =:= NewI -> (Cpf =:= Busca -> NewI9 is I9 + 1 ; NewI9 = I9) ; NewI9 = I9),
    nth0(10, H, I10), % Indice 3
    (10 =:= NewI -> (Cpf =:= Busca -> NewI10 is I10 + 1 ; NewI10 = I10) ; NewI10 = I10),
    cadastrarRecomendacao(Cpf, NewI1, NewI2, NewI3, NewI4, NewI5, NewI6, NewI7, NewI8, NewI9, NewI10),
    reescreveRecomendacao(T, I, Busca).
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

%  Remove um elemento da lista.
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

%  Reescreve CPF e quantidade de uso da vaga no arquivo csv.
reescreveUsoContrato([], _).
reescreveUsoContrato([H|T], Busca):-
    nth0(0, H, Cpf), % Indice 1
    nth0(1, H, Qntd), % Indice 2
    (Busca =:= Cpf -> NewQntd is Qntd + 1 ; NewQntd = Qntd),
    cadastrarUsoDoContrato(Cpf, NewQntd),
    reescreveUsoContrato(T, Busca).

reescreveRenovacao([], _).
reescreveRenovacao([H|T], Busca):-
    nth0(0, H, Cpf), % Indice 1
    nth0(1, H, Qntd), % Indice 2
    nth0(2, H, Tipo), % Indice 3
    (Busca =:= Cpf -> NewQntd = 0 ; NewQntd = Qntd),
    cadastrarUsoDoContrato(Cpf, NewQntd, Tipo),
    reescreveRenovacao(T, Busca).


%  Escreve no arquivos os dados passados.
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

renovacaoDeContrato(Lista):-
    nth0(1, Lista, Qntd),
    nth0(2, Lista, Tipo),
    
    (Tipo == 's', Qntd =:= 7  -> true ; (Tipo == 'm', Qntd =:= 30 -> true ; false)).


reescreveContrato([]).
reescreveContrato([H|T]):-
    nth0(0, H, Cpf), % Indice 1
    nth0(1, H, Qntd), % Indice 2
    nth0(2, H, Tipo), % Indice 3
    cadastrarUsoDoContrato(Cpf, Qntd, Tipo),
    reescreveContrato(T).

reescreveContrato2([]).
reescreveContrato2([H|T]):-
    nth0(0, H, Cpf), % Indice 1
    nth0(1, H, Nome), % Indice 2
    nth0(2, H, Placa), % Indice 3
    nth0(3, H, Vaga), % Indice 3
    nth0(4, H, Tipo), % Indice 3
    cadastrarContrato(Cpf, Nome, Placa, Vaga, Tipo),
    reescreveContrato2(T).

excluirUsoDoContrato(Cpf, Result):-
    
    removegg(Cpf, Result, X),
    remove(X, Result, ContratosExc),
    limpaCsv('usoDoContrato.csv'),
    reescreveContrato(ContratosExc).

excluirContratos(Cpf2, Result2):-

    removegg(Cpf2, Result2, X2),
    remove(X2, Result2, ContratosExc2),
    limpaCsv('contratos.csv'),
    reescreveContrato2(ContratosExc2).
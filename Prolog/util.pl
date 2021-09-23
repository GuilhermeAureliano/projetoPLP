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

remove_member(_, [], false).
remove_member(Busca, [H|T], R):-
    (member(Busca, H) -> remove(Busca, H) ; remove_member(Busca, T, R)
    ).

%  Remove um elemento da lista.
remove(X, [X|T], T).
remove(X, [H|T], [H|T1]):- remove(X,T,T1).

%  Escreve o cliente no arquivo csv.
cadastrarCliente(Cpf, Nome, Placa):-
    open('./dados/clientes.csv', append, Fluxo),
    writeln(Fluxo, (Cpf, Nome, Placa)),
    close(Fluxo).

%  Escreve o funcionário no arquivo csv.
cadastrarFuncionario(Cpf, Nome):-
    open('./dados/funcionarios.csv', append, Fluxo),
    writeln(Fluxo, (Cpf, Nome)),
    close(Fluxo).

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

%  Escreve o cliente no arquivo csv.
cadastrarCliente(Cpf, Nome, Placa):-
    open('./dados/clientes.csv', append, Fluxo),
    writeln(Fluxo, (Cpf, Nome, Placa)),
    close(Fluxo).
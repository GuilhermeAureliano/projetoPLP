:-use_module(library(csv)).
:- include('mensagens.pl').
:- include('util.pl').


verificaFuncionario(Menu):-
    cpfParaLogin,
    read(Cpf),

    lerArquivoCsv('funcionarios.csv', Result),
    ehMember(Cpf, Result, Resposta),
    (Resposta -> loginFuncionario(Menu) ; usuarioInvalido, Menu).



loginFuncionario(Menu):-
    menuFuncionario,
    read(Opcao),
    opcoesFuncionario(Opcao, Menu),
    halt.

opcoesFuncionario(1, Menu):- listarVagasFuncionarios, loginFuncionario(Menu).
opcoesFuncionario(2, Menu):- escolherVaga(Menu), loginFuncionario(Menu).
opcoesFuncionario(3, Menu):- exibirClientes, loginFuncionario(Menu).
opcoesFuncionario(4, Menu):- excluirCliente, loginFuncionario(Menu).
opcoesFuncionario(5, Menu):- calcularValorEstacionamento(Menu), loginFuncionario(Menu).
opcoesFuncionario(6, Menu):- Menu.


calcularValorEstacionamento(Menu):-
    informeCpf,
    read(Cpf),

    lerArquivoCsv('cpvhs.csv', Result),
    ehMember(Cpf, Result, Resposta),
    (Resposta -> write("") ; usuarioInvalido, loginFuncionario(Menu)),

    removegg(Cpf, Result, X),

    nth0(2, X, Vaga),
    cadastrarVaga(Vaga),

    remove(X, Result, CpvhsExc),

    limpaCsv('cpvhs.csv'),

    reescreveCpvhs(CpvhsExc).


escolherVaga(Menu):-
    writeln("\nPara continuar vai ser preciso efetuar um cadastro no sistema!\n"),

    informeCpf,
    read(Cpf),
    
    lerArquivoCsv('cpvhs.csv', Result),
    ehMember(Cpf, Result, Resposta),
    (Resposta -> usuarioVagaOcupada, loginCliente(Menu) ; write("")),    
    
    lerArquivoCsv('clientes.csv', Result2),
    ehMember(Cpf, Result2, Resposta2),
    (Resposta2 -> usuarioCadastrado, cadastrarPlaca, read(Placa) ; write("")),

    informeNome,
    read(Nome),
    cadastrarPlaca,
    read(Placa),
    
    lerArquivoCsv('vagas.csv', Result3),
    writeln(Result3),
    writeln("\nQual vaga o senhor deseja?"),
    read(Vaga),

    writeln("\nDeseja adicionar servico extra de lava-jato e cera? [S/N]"),
    read(Service),

    cadastraHorarioEntrada,
    read(Hora),

    cadastrarCpv(Cpf, Placa, Vaga, Hora, Service),
    cadastrarCliente(Cpf, Nome, Placa),
    cadastradoEfetuado,
    opcaoVaga(Vaga).


listarVagasFuncionarios:-
    writeln("\n           -----LISTA DAS VAGAS DISPONIVEIS-----\n"),
    lerArquivoCsv('vagas.csv', Result),
    sort(Result, Sort),
    writeln(Sort).


exibirClientes:-
    writeln("       -----CLIENTES CADASTRADOS-----"),
    lerArquivoCsv('clientes.csv', Result),
    writeln(Result).

excluirCliente:-
    writeln("Informe o CPF do cliente que deseja excluir: "),
    read(Cpf),
    
    lerArquivoCsv('clientes.csv', Result),
    ehMember(Cpf, Result, Resposta),
    (Resposta -> writeln("") ; usuarioInvalido, loginFuncionario(Menu)),
    
    removegg(Cpf, Result, X),
    remove(X, Result, ClientesExc),

    limpaCsv('clientes.csv'),

    reescreveCliente(ClientesExc),
    writeln("\nCliente excluido com sucesso!").
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

% opcoesFuncionario(1, Menu):- listarVagasDisponiveis, loginFuncionario(Menu).
% opcoesFuncionario(2, Menu):- escolherVaga(Menu), loginFuncionario(Menu).
opcoesFuncionario(3, Menu):- exibirClientes, loginFuncionario(Menu).
% opcoesFuncionario(4, Menu):- assinarContrato, loginFuncionario(Menu).
% opcoesFuncionario(5, Menu):- clienteComContrato, loginFuncionario(Menu).
opcoesFuncionario(6, Menu):- Menu.

exibirClientes:-
    writeln("       -----CLIENTES CADASTRADOS-----"),
    lerArquivoCsv('clientes.csv', Result),
    writeln(Result).
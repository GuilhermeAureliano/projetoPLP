:- (initialization main).
:- include('mensagens.pl').
:- include('cliente.pl').
:- include('funcionario.pl').
:- include('dono.pl').


main:-
    menuPrincipal,
    read(Opcao),
    escolheOpcao(Opcao),
    halt.

escolheOpcao(1):- loginCliente(main).
escolheOpcao(2):- verificaFuncionario(main).
escolheOpcao(3):- verificaDono(main).
escolheOpcao(4):- halt.
escolheOpcao(_):- opcaoInvalida, main.
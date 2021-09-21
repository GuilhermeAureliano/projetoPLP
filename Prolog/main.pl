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
escolheOpcao(2):- loginFuncioanrio.
escolheOpcao(3):- loginDono.
escolheOpcao(4):- halt.
escolheOpcao(_):- opcaoInvalida, main.
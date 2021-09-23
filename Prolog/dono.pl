:-use_module(library(csv)).
:- include('mensagens.pl').
:- include('util.pl').


verificaDono(Menu):-
    cpfParaLogin,
    read(Cpf),

    lerArquivoCsv('dono.csv', Result),
    ehMember(Cpf, Result, Resposta),
    (Resposta -> loginDono(Menu) ; usuarioInvalido, Menu).

loginDono(Menu):-
    menuDono,
    read(Opcao),
    opcoesDono(Opcao, Menu),
    halt.

opcoesDono(1, Menu):- cadastroDeFuncionario(Menu), loginDono(Menu).
% opcoesDono(2, Menu):- escolherVaga(Menu), loginDono(Menu).
% opcoesDono(3, Menu):- recomendarVaga, loginDono(Menu).
% opcoesDono(4, Menu):- assinarContrato, loginDono(Menu).
% opcoesDono(5, Menu):- clienteComContrato, loginDono(Menu).
opcoesDono(6, Menu):- Menu.

cadastroDeFuncionario(Menu):-
    cadastrarNome,
    read(Nome),

    informeCpf,
    read(Cpf),

    lerArquivoCsv('funcionarios.csv', Result),
    ehMember(Cpf, Result, Resposta),
    (Resposta -> usuarioCadastrado, loginDono(Menu) ; write("")),

    cadastrarFuncionario(Cpf, Nome),
    cadastradoEfetuado.    
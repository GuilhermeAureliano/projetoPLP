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
opcoesDono(2, Menu):- excluirFuncionario(Menu), loginDono(Menu).
opcoesDono(3, Menu):- gerenciarFinancas(Menu), loginDono(Menu).
% opcoesDono(4, Menu):- assinarContrato, loginDono(Menu).
% opcoesDono(5, Menu):- clienteComContrato, loginDono(Menu).
opcoesDono(6, Menu):- Menu.


gerenciarFinancas(Menu):-
    menuFinancas,
    read(Op),

    opcoesFinancas(Op, Menu).

opcoesFinancas(2, Menu):- alterarValor, gerenciarFinancas(Menu).
opcoesFinancas(3, Menu):- loginDono(Menu).

alterarValor:-
    writeln("\nQual o novo valor da hora do estacionamento?"),
    read(NewValue),

    limpaCsv('valorEstacionamento.csv'),

    open('./dados/valorEstacionamento.csv', append, Fluxo),
    writeln(Fluxo, (NewValue)),
    close(Fluxo),

    writeln("\nValor do estacionamento alterado com sucesso!").


excluirFuncionario(Menu):-
    writeln("Informe o CPF do funcionario que deseja excluir: "),
    read(Cpf),

    % writeln("\nAtualmente temos os seguintes clientes no sistema: "),
    % writeln(Result),
    
    lerArquivoCsv('funcionarios.csv', Result),
    ehMember(Cpf, Result, Resposta),
    (Resposta -> writeln("") ; usuarioInvalido, loginDono(Menu)),
    
    removegg(Cpf, Result, X),
    remove(X, Result, FuncionariosExc),

    limpaCsv('funcionarios.csv'),

    reescreveFuncionario(FuncionariosExc),
    writeln("\nFuncionario excluido com sucesso!").

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
:- include('mensagens.pl').

loginCliente(Menu):-
    menuDoCliente,
    read(Opcao),
    opcoesCliente(Opcao, Menu),
    halt.

opcoesCliente(1, Menu):- listarVagasDisponiveis, loginCliente(Menu).
opcoesCliente(2, Menu):- escolherVaga, loginCliente(Menu).
opcoesCliente(3, Menu):- recomendarVaga, loginCliente(Menu).
opcoesCliente(4, Menu):- assinarContrato, loginCliente(Menu).
opcoesCliente(5, Menu):- clienteComContrato, loginCliente(Menu).
opcoesCliente(6, Menu):- Menu.

%  Escolhe uma vaga das disponíveis
escolherVaga:-
    writeln("\nPara continuar vai ser preciso efetuar um cadastro no sistema!\n"),

    informeCpf,
    read(Cpf),

    open('dados/clientes.txt', append, Fluxo),
    writeln(Fluxo, "Oi"),
    close(Fluxo).


listarVagasDisponiveis:-
    writeln("\n           -----LISTA DAS VAGAS DISPONIVEIS-----\n"),
    writeln("exibindo lista -----").

recomendarVaga:-
    informeCpf,
    read(Cpf),
    
    writeln("Nos recomendamos a voce a vaga: ").

assinarContrato:-
    informeCpf,
    read(Cpf),

    writeln("\nVoce ja tem contrato ativo! Tecle 5 na area do cliente para usar seu contrato!\n"),

    writeln("Informe seu nome: "),
    read(Nome),

    cadastrarPlaca,
    read(Placa),

    write("       -----VAGAS DISPONIVEIS-----\n"),
    writeln("Lista das vagas"),

    writeln("Qual vaga voce deseja?"),
    read(Vaga),

    write("Qual o tipo de contrato? \n"),
    write("O nosso mensal custa 150$ reais.\n"),
    write("Ja o nosso contrato semanal custa 25$ reais.\n"),
    write("\nQual o senhor ira assinar? [S/M] "),
    read(Contrato).

clienteComContrato:-
    informeCpf,
    read(Cpf),

    writeln("\nAtualmente temos os seguintes clientes ativos e suas respectivas vagas: "),
    writeln("Lista das vagas....").
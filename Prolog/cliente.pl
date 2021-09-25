:-use_module(library(csv)).
:- include('mensagens.pl').
:- include('util.pl').


loginCliente(Menu):-
    menuDoCliente,
    read(Opcao),
    opcoesCliente(Opcao, Menu),
    halt.

opcoesCliente(1, Menu):- listarVagasDisponiveis, loginCliente(Menu).
opcoesCliente(2, Menu):- escolherVaga(Menu), loginCliente(Menu).
opcoesCliente(3, Menu):- recomendarVaga, loginCliente(Menu).
opcoesCliente(4, Menu):- assinarContrato, loginCliente(Menu).
opcoesCliente(5, Menu):- clienteComContrato, loginCliente(Menu).
opcoesCliente(6, Menu):- Menu.

%  Escolhe uma vaga das disponíveis
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

listarVagasDisponiveis:-
    writeln("\n           -----LISTA DAS VAGAS DISPONIVEIS-----\n"),
    lerArquivoCsv('vagas.csv', Result),
    sort(Result, Sort),
    writeln(Sort).

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

    msgAssinarContrato,
    read(Contrato).

clienteComContrato:-
    informeCpf,
    read(Cpf),

    writeln("\nAtualmente temos os seguintes clientes ativos e suas respectivas vagas: "),
    writeln("Lista das vagas....").

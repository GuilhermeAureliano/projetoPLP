
menuPrincipal:-
    writeln("\n           -----MENU PRINCIPAL-----"),
    writeln("\nComo deseja prosseguir?"),
    writeln("[1] Area do Cliente"),
    writeln("[2] Login como funcionario"),
    writeln("[3] Login como dono"),
    writeln("[4] Sair\n").

opcaoInvalida:-
    writeln("\nError: OPCAO INVALIDA").

mensagemDeSaida:-
    writeln("\nHasta La Vista...E volte sempre!").

menuDoCliente:-
    writeln("\n       -----AREA DO CLIENTE-----"),
    writeln("\nOla, Cliente!"),
    writeln("\nComo deseja prosseguir?"),
    writeln("[1] Listar vagas disponiveis"),
    writeln("[2] Escolher vaga"),
    writeln("[3] Recomendacao de vaga do Estacionamento"),
    writeln("[4] Assinar contrato de exclusividade"),
    writeln("[5] Ocupar vaga para clientes com contrato"),
    writeln("[6] Voltar ao menu principal").
    
    
usuarioInvalido:-
    writeln("\nErro: usuario não cadastrado!").

usuarioCadastrado:-
    writeln("\nUsuario ja cadastrado!").

usuarioVagaOcupada:-
    writeln("\nErro: usuario ja esta ocupando uma vaga!").

cpfInvalido:-
    writeln("\nErro: CPF invalido!").

menuFuncionario:-
    writeln("\n       -----FUNCIONARIO-----"),
    writeln("\nOla, funcionario!"),
    writeln("\nComo deseja prosseguir?"),
    
    writeln("[1] Listar vagas disponiveis"),
    writeln("[2] Escolher vaga para um cliente"),
    writeln("[3] Exibir clientes cadastrados"),
    writeln("[4] Excluir cliente do sistema"),
    writeln("[5] Calcular valor do estacionamento"),
    writeln("[6] Voltar ao menu principal\n").
    

menuFinancas:-
    writeln("\n       -----AREA DE FINANCAS-----"),
    writeln("Como deseja prosseguir?"),

    writeln("[1] Visualizar contratos ativos"), 
    writeln("[2] Alterar valor da hora do estacionamento"), 
    writeln("[3] Voltar ao login do dono\n").
    
cadastrarNome:-
    writeln("\n       -----CADASTRO DE USUARIO-----"),
    writeln("\nInforme o nome: ").

informeCpf:-
    writeln("Informe seu CPF: ").

informeNome:-
    writeln("Informe seu nome: ").

cadastrarPlaca:-
    writeln("Informe a placa do veiculo: ").

cadastraHorarioEntrada:-
    writeln("Hora de entrada(numeros): ").

horaDeSaida:-
    writeln("Hora de saida: ").

exibirContratosAtivos:-
    writeln("       -----CLIENTES COM CONTRATOS-----"),
    writeln("\nExibe os clientes com contratos do arquivo").

exibirListaClientesCadastrados:-
    writeln("       -----CLIENTES CADASTRADOS-----"),
    writeln("\nExibe os clientes cadastrados do arquivo").

menuDono:-
    writeln("\n       -----DONO-----"),
    writeln("\nOi, chefinho!"),
    writeln("\nComo deseja prosseguir?"),

    writeln("[1] Cadastrar funcionario"),
    writeln("[2] Excluir funcionarios"),
    writeln("[3] Gerenciar financas"),
    writeln("[4] Visualizar funcionarios ativos"),
    writeln("[5] Visualizar clientes ativos"),
    writeln("[6] Voltar ao menu principal\n").


exibirListaFuncionariosCadastrados:-
    writeln("       -----FUNCIONARIOS CADASTRADOS-----"),
    writeln("\nLista dos FUNCIONARIOS cadastrado do arquivo").

cpfParaLogin:-
    writeln("\nInforme seu CPF para fazer o login: ").

% valorPago :: String -> [[String]] -> IO()
valorPago:-
    writeln("\nO valor a ser pago em REAIS pelo cliente NOME é: ").

cadastradoEfetuado:-
    writeln("\nCADASTRADO EFETUADO COM SUCESSO!").
    
msgAssinarContrato:-
    writeln("\nO nosso contrato mensal custa 150$ reais."),
    writeln("Ja o semanal custa 25$ reais."),
    writeln("Qual contrato o senhor ira assinar? [S/M]").
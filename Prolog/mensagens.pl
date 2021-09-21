
menuPrincipal():-
    writeln("\n           -----MENU PRINCIPAL-----"),
    writeln("\nComo deseja prosseguir?"),
    writeln("[1] Área do Cliente"),
    writeln("[2] Login como funcionário"),
    writeln("[3] Login como dono"),
    writeln("[4] Sair\n").

opcaoInvalida:-
    writeln("\nError: OPCAO INVALIDA\n").

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
    writeln("[6] Voltar ao menu principal\n").
    
    
usuarioInvalido:-
    writeln("\nErro: usuário não cadastrado!\n").

usuarioCadastrado:-
    writeln("\nErro: usuário já cadastrado!").

usuarioVagaOcupada:-
    writeln("\nErro: usuário já está ocupando uma vaga!").

cpfInvalido:-
    writeln("\nErro: CPF inválido!").

menuFuncionario:-
    writeln("\n       -----FUNCIONÁRIO-----"),
    writeln("\nOlá, funcionário!"),
    writeln("\nComo deseja prosseguir?"),
    writeln("[1] Listar vagas disponíveis"),
    writeln("[2] Escolher vaga para um cliente"),
    writeln("[3] Exibir clientes cadastrados"),
    writeln("[4] Excluir cliente do sistema"),
    writeln("[5] Calcular valor do estacionamento"),
    writeln("[6] Voltar ao menu principal\n").
    

menuFinancas:-
    writeln("\n       -----ÁREA DE FINANÇAS-----"),
    writeln("\nComo deseja prosseguir?"), 
    writeln("[1] Visualizar contratos ativos"), 
    writeln("[2] Alterar valor da hora do estacionamento"), 
    writeln("[3] Voltar ao login do dono\n").
    
cadastrarNome:-
    writeln("\n       -----CADASTRO DE USUÁRIO-----"),
    writeln("\nInforme o nome: ").

informeCpf:-
    writeln("Informe o CPF: ").

cadastrarPlaca:-
    writeln("Informe a placa do veiculo: ").

cadastraHorarioEntrada:-
    writeln("Por fim, o horario de entrada(números): ").

horaDeSaida:-
    writeln("Hora de saída: ").

exibirContratosAtivos:-
    writeln("       -----CLIENTES COM CONTRATOS-----\n"),
    writeln("Exibe os clientes com contratos do arquivo").

exibirListaClientesCadastrados:-
    writeln("       -----CLIENTES CADASTRADOS-----\n"),
    writeln("Exibe os clientes cadastrados do arquivo").

menuDono:-
    writeln("\n       -----DONO-----"),
    writeln("\nOi, chefinho!"),

    writeln("\nComo deseja prosseguir?"),
    writeln("[1] Cadastrar funcionário"),
    writeln("[2] Excluir funcionários"),
    writeln("[3] Gerenciar finanças"),
    writeln("[4] Visualizar funcionários ativos"),
    writeln("[5] Visualizar clientes ativos"),
    writeln("[6] Voltar ao menu principal\n").


exibirListaFuncionariosCadastrados:-
    writeln("       -----FUNCIONARIOS CADASTRADOS-----\n"),
    writeln("Lista dos FUNCIONARIOS cadastrado do arquivo").

cpfParaLogin:-
    writeln("\nInforme seu CPF para fazer o login: ").

% valorPago :: String -> [[String]] -> IO()
valorPago:-
    writeln("O valor a ser pago em REAIS pelo cliente NOME é: ").

cadastradoEfetuado:-
    writeln("\nCADASTRADO EFETUADO COM SUCESSO!").
    
    
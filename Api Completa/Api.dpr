program Api;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  Horse.Logger,
  Horse.Logger.Provider.Console,
  controller.login in 'src\controller.login.pas',
  model.con in 'src\model\model.con.pas' {DmCon: TDataModule},
  model.login in 'src\model\model.login.pas' {DmLogin: TDataModule},
  model.pessoas in 'src\model\model.pessoas.pas' {DmPessoas: TDataModule},
  controller.pessoas in 'src\controller\controller.pessoas.pas',
  controller.jwt in 'src\controller\controller.jwt.pas';


   var LLogFileConfig: THorseLoggerConsoleConfig;

begin

  THorse.Use(Jhonson());

  LLogFileConfig := THorseLoggerConsoleConfig.New
    .SetLogFormat('${request_clientip} [${time}] ${response_status}');

  THorseLoggerManager.RegisterProvider(THorseLoggerProviderConsole.New(LLogFileConfig));

  THorseLoggerManager.RegisterProvider(THorseLoggerProviderConsole.New());

  THorse.Use(THorseLoggerManager.HorseCallback);

  controller.login.Login;
  controller.pessoas.Pessoas;

  THorse.Listen(9000);
end.
 
end.

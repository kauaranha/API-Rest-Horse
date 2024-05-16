unit controller.pessoas;

interface

uses Horse, system.JSON, model.pessoas, Model.con, System.SysUtils, Horse.JWT,
controller.jwt;

procedure Get(Req : THorseRequest; Res : THorseResponse; NExt : TProc);
procedure GetID(Req : THorseRequest; Res : THorseResponse; NExt : TProc);
procedure Post(Req: THorseRequest; Res: THorseResponse);
procedure DeleteUser(Req : THorseRequest; Res : THorseResponse; NExt : TProc);
procedure Pessoas;

implementation

procedure Pessoas;
begin
   THorse.Post('/pessoas', Post);
   THorse.Get('/pessoas', Get);
   THorse.Get('/pessoas/:id', GetID);
   THorse.Delete('/pessoas/:id', DeleteUser);
end;

procedure Get(Req : THorseRequest; Res : THorseResponse; NExt : TProc);
var
LdmPessoas : TdmPessoas;
begin
   try
      LdmPessoas := TdmPessoas.Create(nil);
      try
           Res.Send<TJSONArray>(LdmPessoas.Pessoas(TJSONArray.ParseJSONValue(REq.Body) as TJSONArray));
      finally
           FreeAndNil(LdmPessoas);
      end;
   except
      on e:exception do begin
          res.Status(400);
          res.Send(e.Message);
      end;
   end;
end;

procedure GetID(Req : THorseRequest; Res : THorseResponse; NExt : TProc);
var
LdmPessoas : TdmPessoas;
begin
   try
      LdmPessoas := TdmPessoas.Create(nil);
      try
           res.Send<TJSONObject>(LdmPessoas.PessoasID(StrToIntDef(req.Params.Items['id'],-1)));

      finally
           FreeAndNil(LdmPessoas);
      end;
   except
      on e:exception do begin
          res.Send(e.Message);
      end;
   end;
end;

procedure DeleteUser(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
LdmPessoas : TdmPessoas;
id : Integer;
begin
  try
    LdmPessoas := TdmPessoas.Create(nil);
    try
       id := Req.Params['id'].ToInteger;

        LdmPessoas.Delete(id);
        Res.Send('Usuario de ID: ' + IntToStr(id) + ' Excluido com Sucesso!');

    finally
       FreeAndNil(LdmPessoas);
    end;
    except on e: exception do  begin

      Res.Send(e.Message).Status(400);
      FreeAndNil(LdmPessoas);
    end;
  end;
end;

procedure Post(Req: THorseRequest; Res: THorseResponse);
var
LdmPessoas : TdmPessoas;
JSONRequest : TJSONObject;
Login, Senha : String;
begin
  try
    LdmPessoas := TdmPessoas.create(nil);
    try

       JSONRequest := Req.Body<TJSONObject>;

        res.Send<TJSONObject>(LdmPessoas.Post(TJSONObject.ParseJSONValue(req.Body) as TJSONObject));

    finally
      Res.Status(200);
      FreeAndNil(LdmPessoas);
    end;
  except
    on e: exception do
    begin
      Res.Send(e.Message).Status(400);
      FreeAndNil(LdmPessoas);
    end;

  end;
end;


end.

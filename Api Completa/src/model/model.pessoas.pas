unit model.pessoas;

interface

uses
  System.SysUtils, System.Classes, model.con, System.JSON, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.ConsoleUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, DataSet.Serialize;

type
  TDmPessoas = class(TDmCon)

    tab_pessoas: TFDQuery;
  private
  public
    function Pessoas(ABody: TJSONArray) : TJSONArray;
    function PessoasID(AIdUsuario:Integer) : TJSONObject;
    function Post(ABody: TJSONObject) : TJSONObject;
    function Delete(Id : Integer) : TJSONObject;
  end;

var
  DmPessoas: TDmPessoas;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
function TDmPessoas.Pessoas(ABody: TJSONArray) : TJSONArray;
begin

     tab_pessoas.Open;

     Result := tab_pessoas.ToJSONArray;
end;

function TDmPessoas.PessoasID(AIdUsuario:Integer) : TJSONObject;
begin

  tab_pessoas.Open;
  tab_pessoas.SQL.Add(' where id = :id');
  tab_pessoas.ParamByName('id').AsInteger:= AIdUsuario;
  tab_pessoas.Open;

  Result:= tab_pessoas.ToJSONObject;

end;

function TDmPessoas.Delete(Id : Integer) : TJSONObject;
begin

      tab_pessoas.Open;
      tab_pessoas.SQL.Clear;
      tab_pessoas.SQL.Add('DELETE FROM pessoas WHERE id=:id');
      tab_pessoas.ParamByName('id').Value := id;
      tab_pessoas.ExecSQL;
      Result := tab_pessoas.ToJSONObject;

end;


function TDmPessoas.Post(ABody: TJSONObject): TJSONObject;
begin
  tab_pessoas.Open;

  tab_pessoas.LoadFromJSON(ABody);
  tab_pessoas.Last;
  Result:= tab_pessoas.ToJSONObject;

end;



{$R *.dfm}

end.

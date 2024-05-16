inherited DmLogin: TDmLogin
  object tab_login: TFDQuery
    Connection = DB
    SQL.Strings = (
      'SELECT* FROM clientes'
      'WHERE login = :login'
      'AND senha = :senha')
    Left = 472
    Top = 184
    ParamData = <
      item
        Name = 'LOGIN'
        DataType = ftString
        ParamType = ptInput
        Value = '1'
      end
      item
        Name = 'SENHA'
        DataType = ftString
        ParamType = ptInput
        Value = '1'
      end>
  end
end

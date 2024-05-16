object DmCon: TDmCon
  Height = 600
  Width = 800
  PixelsPerInch = 120
  object DB: TFDConnection
    Params.Strings = (
      'Database=kaua'
      'User_Name=wise'
      'Password=#Ws!0zWISEd1o8d0i5%'
      'Server=187.62.191.20'
      'DriverID=MySQL')
    Left = 390
    Top = 190
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Users\Kaua Aranha\Desktop\libmysql.dll'
    Left = 370
    Top = 340
  end
end

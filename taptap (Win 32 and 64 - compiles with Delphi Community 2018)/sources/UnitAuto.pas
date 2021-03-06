unit UnitAuto;

interface
procedure SetAuto_command(Fileindex:integer;tapname:string;value:boolean);

implementation
uses sysutils,unitutils,classes,generics.collections,Unitchecks;

procedure SetAuto_command(Fileindex:integer;tapname:string;value:boolean);
var f1:TFileStream;
    Catalogue:TList<Toricfile>;
    b:byte;
    i:integer;
begin
  try
    Catalogue:=TList<Toricfile>.Create;
    try
      GetCatalogue(TapName,catalogue);
      if check_1(Fileindex,TapName,Catalogue) then
      begin
        f1:=TFileStream.Create(tapname,fmOpenReadWrite);
        try
          for i := 0 to Catalogue.Count-1 do
          if ((FileIndex=i) or (FileIndex=FI_ALL)) then
          begin
            f1.position:=Catalogue.Items[Fileindex].StartHeader+3;
            if value then b:=$C7 else b:=$0;
            f1.write(b,1);
            write('Auto run of File #'+Fileindex.ToString+' has been set to');
            if value then writeln('"On"') else writeln('"Off"');
          end;
        finally
          f1.Free;
        end;
      end;
    finally
      Catalogue.Free;
    end;
  except
    writeln('Set of auto flag was not performed');
    writeln('An unnatended error occured.');
  end;
end;
end.

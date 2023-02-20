program Master_Mind_3_0;

uses sysutils;

const
  MAX_INTENTOS = 30;
  LARGO_CODIGO = 4;
  PRIMERA_LETRA = 'A';
  ULTIMA_LETRA = 'H';

type
  TLetras = PRIMERA_LETRA.. ULTIMA_LETRA;
  TCodigo = array[1.. LARGO_CODIGO] of TLetras;

  TRegistroNota = record
    codigo: TCodigo;
    buenos, regulares: Integer;
  end;

  THistoria = record
    info: array[1.. MAX_INTENTOS] of TRegistroNota;
    tope: 0.. MAX_INTENTOS;
  end;

var codigoA, codigoS: TCodigo;
    registroNota: TRegistroNota;
    i, bue, reg, l: Byte;
    mensaje: String;
    evaluadasP, evaluadasA: array[1.. LARGO_CODIGO] of Boolean;

procedure generarCodigo(var codigo: TCodigo); begin
  for i:= Low(codigo) to High(codigo) do
    codigo[i]:= Chr(Random(Ord(ULTIMA_LETRA) - Ord(PRIMERA_LETRA) + 1) + Ord(PRIMERA_LETRA));
  i:= 1;
end;

procedure calcularNota(codAdivinador, codPensador: TCodigo; var buenos, regulares: Byte); var i, j: Byte; begin
  for i:= Low(codigoA) to High(codigoA) do begin
    if codPensador[i] = codAdivinador[i] then begin
      buenos+= 1;
      evaluadasP[i]:= True;
      evaluadasA[i]:= True;
    end;
  end;

  for j:= Low(evaluadasA) to High(evaluadasA) do begin
    if evaluadasA[j] = False then begin
      for i:= Low(evaluadasA) to High(evaluadasP) do begin
        if (evaluadasP[i] = False) and (codPensador[i] = codAdivinador[j]) then begin
          regulares+= 1;
          evaluadasP[i]:= True;
          evaluadasA[j]:= True;
        end;
      end;
    end;
  end;
end;

procedure imprimirCodigo(codigo: TCodigo); begin
  for i:= Low(codigo) to High(codigo) do
    Write(codigo[i]);
  i:= 1;
  Write(' ');
end;

procedure siguienteCodigo(var codigo: TCodigo); begin
  i:= High(codigo);
  
  repeat
    if i = High(codigo) then begin
      codigoS[i]:= Chr(Ord(codigoA[i]) + 1);
    end;
    
    if (Ord(codigoA[i]) = 72) then begin
      if i = High(codigo) then begin
        codigoS[i]:= Chr(65);
        codigoS[i-1]:= Chr(Ord(codigoA[i-1]) + 1);
        i-= 1;
      end else if (i <> High(codigo)) and (Ord(codigoA[i]) = 72) and (Ord(codigoA[i+1]) <> 72) then begin
        //codigoS[i]:= Chr(65);
        codigoS[i+1]:= Chr(Ord(codigoA[i+1]) + 1);
        i-= 1;
      end else if (i <> High(codigo)) and (Ord(codigoA[i]) = 72) and (Ord(codigoA[i+1]) = 72) then begin
        j:= i;
        
        repeat 
          codigoS[j]:= Chr(65);
        until j = High(codigo);
        
        codigoS[i-1]:= Chr(Ord(codigoA[i-1]) + 1);
        i-= 1;
        
        if (Ord(codigoA[i]) = 72) then begin
          codigoS[i]:= Chr(65);
        end;
      end;
    end else begin
      i-= 1;
      codigoS[i]:= codigoA[i];
    end;
  until i = Low(codigo);
  
  
  for i:= Low(codigo) to High(codigo) do begin
    codigoA[i]:= codigoS[i];
    
    {*if codigoA[i] <> codigoS[i] then begin
      codigoS[i]:= Chr(Ord(codigoA[i]) + 1);
    end;*}
  end;
end;

function crearHistoria(): THistoria; begin
  //d
end;

function esHistoriaVacia(h: THistoria): Boolean; begin
  //d
end;

procedure guardarNota(var h: THistoria; codigo: TCodigo; buenos, regulares: Integer); begin
  //d
end;

function esAdecuado(c: TCodigo; h: THistoria): Boolean; begin
  //d
end;

begin
  Randomize;
  Write('MasterMind V3.0');
  WriteLn;
  Write('Dispones de ', MAX_INTENTOS, ' para adivinar el codigo');
  WriteLn;
  WriteLn;

  for l:= Low(codigoA) to 255 do begin
    if l= 1 then begin
      generarCodigo(codigoA);
      imprimirCodigo(codigoA);
    end else begin
      siguienteCodigo(codigoS);
      imprimirCodigo(codigoS);
    end;
  end;
  ReadLn;
end.

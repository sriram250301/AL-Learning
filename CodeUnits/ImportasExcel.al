codeunit 50139 "Import Excel"
{
    procedure ImportExcel()
    var

        ExcelBuffer: Record "Excel Buffer" temporary;
        NameValueBuff: Record "Name/Value Buffer";
        Sheet1: Text;
        Instr: InStream;
        RowNo: Integer;
        ColNo: Integer;

        rownum: Integer;

        frmfile: Text;
        instrm: InStream;
    begin
        ExcelBuffer.Reset();
        ExcelBuffer.DeleteAll();
        NameValueBuff.Reset();
        if NameValueBuff.FindSet() then begin
            repeat
                Clear(Sheet1);
                Sheet1 := NameValueBuff.Value;
                ExcelBuffer.OpenBookStream(Instr, Sheet1);
                ExcelBuffer.ReadSheet();

                rownum := 0;
                ExcelBuffer.Reset();
                if ExcelBuffer.FindLast() then
                    rownum := ExcelBuffer."Row No.";

                RowNo := 0;
                ColNo := 0;

                if Sheet1 = 'Purchase Order' then begin
                    ImportPurchaseHeader();
                end;

                if Sheet1 = 'Purchase Line' then begin
                    //ImportPurchaseLine();
                end;



            until NameValueBuff.Next() = 0;
            Message('Sucess');
        end;

    end;


    // Select File

    procedure SelectFile()
    var
        frmfile: Text;
        instrm: InStream;
        filename: Text;
        filemgt: Codeunit "File Management";
        ExcelBuffer: Record "Excel Buffer" temporary;
        NameValueBuff: Record "Name/Value Buffer";

    begin
        UploadIntoStream('Choose the File.', '', '', frmfile, instrm);
        if frmfile <> '' then begin
            filename := filemgt.GetFileName(frmfile);
            ExcelBuffer.GetSheetsNameListFromStream(instrm, NameValueBuff);
        end else
            Error('No Excel fnd');

    end;
    procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    var
        // RowNo: Integer;
        // ColNo: Integer;
        ExcelBuffer: Record "Excel Buffer" temporary;

    begin
        ExcelBuffer.Reset();
        if ExcelBuffer.Get(RowNo, ColNo) then
            exit(ExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;
    procedure ImportPurchaseHeader();
    var
        RowNo: Integer;
        rownum: Integer;
        PurchaseHeader: Record "Purchase Header";

    begin
        for RowNo := 2 to rownum do begin
            Evaluate(PurchaseHeader."Document Type", GetValueAtCell(RowNo, 3));
            Evaluate(PurchaseHeader."Buy-from Vendor No.", GetValueAtCell(RowNo, 4));
            PurchaseHeader.Modify(true);
            ImportPurchaseLine(PurchaseHeader);
        end;
    end;


    procedure ImportPurchaseLine(var PurchaseHeader: Record "Purchase Header")
    var

        RowNo: Integer;
        rownum: Integer;
        LineNo: Integer;
        PurchaseLine: Record "Purchase Line";
        No: Integer;

    begin
        for RowNo := 2 to rownum do begin
            LineNo := 0;
            Evaluate(LineNo, GetValueAtCell(RowNo, 3));

            PurchaseLine.Reset();
            PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
            IF PurchaseLine.FINDFIRST() THEN BEGIN
                EVALUATE(PurchaseLine.Type, GetvalueAtcell(RowNo, 4));
                PurchaseLine.VALIDATE("NO.", GetvalueAtcell(RowNo, 5));
                EVALUATE(PurchaseLine.Quantity, GetvalueAtcell(RowNo, 7));
                PurchaseLine.VALIDATE(Quantity);
                EVALUATE(PurchaseLine."Unit Cost", GetValueAtCell(RowNo, 8));
                PurchaseLine.VALIDATE("Unit Cost");
                PurchaseLine.MODIFY(TRUE);
            END ELSE BEGIN
                PurchaseLine.INIT();
                PurchaseLine.VALIDATE("Document Type", PurchaseHeader."Document Type");
                EVALUATE(PurchaseLine."Document No.", PurchaseHeader."No.");
                EVALUATE(PurchaseLine."Line No.", GetvalueAtcell(RowNo, 3));
                EVALUATE(PurchaseLine.Quantity, GetValueAtCell(RowNo, 7));
                PurchaseLine.VALIDATE(Quantity);
                EVALUATE(PurchaseLine."Unit Cost", GetValueAtCell(RowNo, 8));
                PurchaseLine.VALIDATE("Unit Cost");
                PurchaseLine.INSERT();
            END;
        end;
    end;
}
codeunit 50123 "SalesOrderXMLOperations"
{

    procedure ExportSalesOrder()
    var
        myInt: Integer;
        XmlDoc: XmlDocument;
        XmlDecl: XmlDeclaration;
        Root: XmlElement;
        ParentNode: XmlElement;
        ParentNode2: XmlElement;
        Values: XmlElement;
        XmlTxt: XmlText;
        Fieldcap: Text;
        XmlAtte: XmlAttribute;
        SalesLineRec: Record "Sales Line";
        SalesHeaderRec: Record "Sales Header";
        TempBlob: Codeunit "Temp Blob";
        Ins: InStream;
        Ots: OutStream;
        Read: Text;
        Write: Text;
    begin

        XmlDoc := XmlDocument.Create();
        XmlDecl := XmlDeclaration.Create('1.0', 'UTF-8', 'yes');
        XmlDoc.SetDeclaration(XmlDecl);
        Root := XmlElement.Create('Root');
        XmlDoc.Add(Root);
        SalesHeaderRec.SetRange("Document Type", SalesHeaderRec."Document Type"::Order);
        SalesHeaderRec.FindSet();

        repeat

            ParentNode := XmlElement.Create('Sales_Header');
            Root.Add(ParentNode);
            //
            Values := XmlElement.Create('DocType');
            XmlTxt := XmlText.Create(Format(SalesHeaderRec."Document Type"));
            Values.Add(XmlTxt);
            ParentNode.Add(Values);
            //
            Values := XmlElement.Create('OrderNo');
            XmlTxt := XmlText.Create(Format(SalesHeaderRec."No."));
            Values.Add(XmlTxt);
            ParentNode.Add(Values);

            SalesLineRec.SetRange("Document No.", SalesHeaderRec."No.");
            SalesLineRec.SetRange("Document Type", SalesLineRec."Document Type"::Order);
                
            if SalesLineRec.FindSet() then
                repeat

                    ParentNode2 := XmlElement.Create('Line_Informations');
                    ParentNode.Add(ParentNode2);

                    Values := XmlElement.Create('LineNo');
                    XmlTxt := XmlText.Create(Format(SalesLineRec."Line No."));
                    Values.Add(XmlTxt);
                    ParentNode2.Add(Values);

                    Values := XmlElement.Create('DocType');
                    XmlTxt := XmlText.Create(Format(SalesLineRec."Document Type"));
                    Values.Add(XmlTxt);
                    ParentNode2.Add(Values);

                    Values := XmlElement.Create('DocNo');
                    XmlTxt := XmlText.Create(Format(SalesLineRec."Document No."));
                    Values.Add(XmlTxt);
                    ParentNode2.Add(Values);

                    Values := XmlElement.Create('ItemNo');
                    XmlTxt := XmlText.Create(Format(SalesLineRec."No."));
                    Values.Add(XmlTxt);
                    ParentNode2.Add(Values);

                until SalesLineRec.Next() = 0;
        until SalesHeaderRec.Next() = 0;

        TempBlob.CreateInStream(Ins);
        TempBlob.CreateOutStream(Ots);
        XmlDoc.WriteTo(Ots);
        Ots.WriteText(Write);
        Ins.ReadText(Write);
        Read := 'Export Sales Orders.XML';
        DownloadFromStream(Ins, '', '', '', Read);
    end;

    procedure ImportSalesOrder()
    var
        SourceFile: Text;
        Ins: InStream;
        XmlDoc: XmlDocument;
        XmlEle: XmlElement;
        Customer: Record Customer;
        SH: Record "Sales Header";
        SL: Record "Sales Line";
        NodeList: XmlNodeList;
        NodeList2: XmlNodeList;
        NodeList3: XmlNodeList;
        NodeList4: XmlNodeList;
        Ele: XmlElement;
        Node1: XmlNode;
        Node2: XmlNode;
        Node3: XmlNode;
        Node4: XmlNode;
        NumberSeries: Record "No. Series";
        LineNo: Integer;
    begin
        //Set number series
        NumberSeries.Get('S-ORD');
        NumberSeries."Manual Nos." := true;
        NumberSeries.Modify();
        if UploadIntoStream('Uploading file', '', '', SourceFile, Ins) then
            XmlDocument.ReadFrom(Ins, XmlDoc)
        else
            Error('Error parsing the uploaded file');

        if XmlDoc.GetRoot(XmlEle) then
            NodeList := XmlEle.GetChildElements();
        foreach Node1 in NodeList do begin
            SH.Init();
            Ele := Node1.AsXmlElement();
            NodeList2 := Ele.GetChildElements();
            foreach Node2 in NodeList2 do begin
                case Node2.AsXmlElement().Name of
                    'DocType':
                        begin
                            Evaluate(SH."Document Type", Node2.AsXmlElement().InnerText);
                        end;
                    'OrderNo':
                        begin
                            SH.Validate("No.", Node2.AsXmlElement().InnerText);
                        end;
                    'CustNo':
                        SH.Validate("Sell-to Customer No.", Node2.AsXmlElement().InnerText);
                end;
            end;
            SH.Insert();
        end;

        foreach Node2 in NodeList2 do begin

            case Node2.AsXmlElement().Name of
                'Line_Informations':
                    begin
                        SL.Init();
                        NodeList3 := Node2.AsXmlElement().GetChildElements();
                        foreach node3 in nodelist3 do begin
                            case Node3.AsXmlElement().Name of
                                'LineNo':
                                    begin
                                        Evaluate(SL."Line No.", Node3.AsXmlElement().InnerText);
                                    end;
                                'LineDocType':
                                    begin
                                        Evaluate(SL."Document Type", Node3.AsXmlElement().InnerText);
                                    end;
                                'Type':
                                    Evaluate(SL.Type, Node3.AsXmlElement().InnerText);
                                'DocNo':
                                    SL.Validate("Document No.", Node3.AsXmlElement().InnerText);
                                'ItemNo':
                                    begin
                                        SL.Validate("No.", Node3.AsXmlElement().InnerText);
                                    end;
                                'Qty':
                                    Evaluate(SL.Quantity, Node3.AsXmlElement().InnerText);

                            end;
                        end;
                        SL.Insert();
                    end;
            end;
        end;
    end;
}
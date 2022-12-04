codeunit 50126 XMLOperations
{
    procedure ExportAsXML()
    var
        MyXmlDocument: XmlDocument;
        RootNodeElement: XmlElement;
        MyXMLDeclaration: XmlDeclaration;
        ParentNodeElement: XmlElement;
        ChildNodeElement: XmlElement;
        XmlAttr: XmlAttribute;
        XmlTxt: XmlText;
        //
        MyTestTable: Record MyTestTable;
        //
        Tempblob: Codeunit "Temp Blob";
        instrm: InStream;
        outstrm: OutStream;
        ReadTxt: Text;
        writetxt: Text;

    begin
        MyXmlDocument := XmlDocument.Create();
        MyXMLDeclaration := XmlDeclaration.Create('1.0', 'UTF-8', 'Yes');
        MyXmlDocument.SetDeclaration(MyXMLDeclaration);
        RootNodeElement := XmlElement.Create('MyTestTableList');

        MyXmlDocument.Add(RootNodeElement);
        MyTestTable.FindSet();

        repeat
            ParentNodeElement := XmlElement.Create('Entity');
            RootNodeElement.Add(ParentNodeElement);

            //ChildNode MyTestTable No.
            ChildNodeElement := XmlElement.Create('Name');
            XmlTxt := XmlText.Create(MyTestTable.Name);
            ChildNodeElement.Add(XmlTxt);
            ParentNodeElement.Add(ChildNodeElement);

            //ChildNode Age
            ChildNodeElement := XmlElement.Create('Age');
            XmlTxt := XmlText.Create(format(MyTestTable.Age));
            ChildNodeElement.Add(XmlTxt);
            ParentNodeElement.Add(ChildNodeElement);

        until MyTestTable.Next() = 0;
        //
        Tempblob.CreateInStream(instrm);
        Tempblob.CreateOutStream(outstrm);
        MyXmlDocument.WriteTo(outstrm);
        outstrm.WriteText(writetxt);
        instrm.ReadText(writetxt);
        ReadTxt := 'MyTest.xml';
        DownloadFromStream(instrm, '', '', '', ReadTxt);

    end;

    procedure ImportasXML()
    var
        InstreamVar: InStream;
        MyFile: Text;
        MyXmlDocument: XmlDocument;
        //
        RootNode: XmlElement;
        ParentNodesList: XmlNodeList;
        ParentNode: XmlNode;
        ParentElement: XmlElement;
        ChildNodesList: XmlNodeList;
        ChildNode: XmlNode;
        ChildElement: XmlElement;
        //
        MyTestTable: Record MyTestTable;

    begin
        if UploadIntoStream('Importing data', '', '', MyFile, InstreamVar) then
            XmlDocument.ReadFrom(InstreamVar, MyXmlDocument)
        else
            Message('Selected file is invalid :(');

        if MyXmlDocument.GetRoot(RootNode) then
            ParentNodesList := RootNode.GetChildElements()
        else
            Message('Root node not found :(');
        foreach ParentNode in ParentNodesList do begin
            MyTestTable.Init();
            ParentElement := ParentNode.AsXmlElement();
            ChildNodesList := ParentElement.GetChildElements();
            foreach ChildNode in ChildNodesList do begin
                case ChildNode.AsXmlElement().Name of
                    'Name':
                        MyTestTable.Validate(Name, ChildNode.AsXmlElement().InnerText);
                    'Age':
                        begin
                            Evaluate(MyTestTable.Age, ChildNode.AsXmlElement().InnerText);
                        end;
                end;
            end;
            MyTestTable.Insert();
        end;
    end;
}
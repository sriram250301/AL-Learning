codeunit 50124 JSONOperations
{
    procedure ExportAsJSON()
    var
        Parent: JsonObject;
        ParentArray: JsonArray;
        SubParent: JsonObject;
        ChildObject: JsonObject;
        ChildArray: JsonArray;
        MyTestTable: Record MyTestTable;
        //
        TempBlob: Codeunit "Temp Blob";
        InstreamObj: InStream;
        OutreamObj: OutStream;
        Data: Text;
        FileName: Text;
    begin
        MyTestTable.FindSet();
        repeat
            SubParent.Add('ID', MyTestTable.ID);
            SubParent.Add('Name', MyTestTable.Name);
            SubParent.Add('Balance', MyTestTable.Balance);

            //Child object value initialization
            ChildObject.Add('City code', MyTestTable.CityCode);
            MyTestTable.CalcFields(CityName);
            ChildObject.Add('City Name', MyTestTable.CityName);

            //Array initialization
            ChildArray.Add(ChildObject);

            //Add child arr to parent
            SubParent.Add('Affiliated locations', ChildArray);

            //Adding Parent array to Parent object
            ParentArray.Add(SubParent);

            Clear(ChildArray);
            Clear(ChildObject);
            Clear(SubParent);

        until MyTestTable.Next() = 0;

        Parent.Add('Test', ParentArray);

        //Download file
        TempBlob.CreateInStream(InstreamObj);
        TempBlob.CreateOutStream(OutreamObj);
        Parent.WriteTo(OutreamObj);
        OutreamObj.WriteText(Data);
        InstreamObj.ReadText(Data);
        FileName := 'MyTestTableExported.json';
        DownloadFromStream(InstreamObj, '', '', '', FileName);

    end;

    procedure GetJSONFromHTTPClient(): Text
    var
        MyHTTPClient: HttpClient;
        HTTPResponse: HttpResponseMessage;
        Request: HttpRequestMessage;
        RecievedHTTPContent: HttpContent;
        RecievedData: Text;
        Headers: HttpHeaders;
    begin
        if MyHTTPClient.Get('https://637e06d39c2635df8f96a44e.mockapi.io/Entities', HTTPResponse) then
            if HTTPResponse.IsSuccessStatusCode then begin
                RecievedHTTPContent := HTTPResponse.Content;
                RecievedHTTPContent.ReadAs(RecievedData);
                exit(RecievedData);
            end
            else
                Message(Format(HTTPResponse.ReasonPhrase));
    end;

    procedure ImportAsJSON()
    var
        ResponseBody: HttpResponseMessage;
        MyTestTable: Record MyTestTable;
        ID: Integer;
        DataFromRestAPI: Text;
        //
        MyJSONObject: JsonObject;
        MyJSONToken: JSONToken;
    begin
        MyTestTable.FindLast();
        ID := MyTestTable.ID + 1;
        Clear(MyTestTable);
        //
        DataFromRestAPI := GetJSONFromHTTPClient();
        MyJSONObject.ReadFrom(DataFromRestAPI);
        MyTestTable.ID := ID;
        MyJSONObject.Get('Name', MyJSONToken);
        MyTestTable.Name := MyJSONToken.AsValue().AsText();
        MyJSONObject.Get('Balance', MyJSONToken);
        MyTestTable.Balance := MyJSONToken.AsValue().AsInteger();
        MyTestTable.Insert();
    end;
}
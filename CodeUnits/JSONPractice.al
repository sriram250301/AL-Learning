codeunit 50135 JSONPractice
{
    procedure ExportJSONPractice()
    var
        MyTestTable: Record MyTestTable;
        Parent: JsonObject;
        SubParent: JsonObject;
        Child: JsonObject;
        ParentArray: JsonArray;
        //
        TempBlob: Codeunit "Temp Blob";
        Instr: InStream;
        Outstr: OutStream;
        Data: Text;
        FileName: Text;
    begin
        MyTestTable.FindSet();

        repeat

            //Defining SubParent JSON Object
            SubParent.Add('ID', MyTestTable.ID);
            SubParent.Add('Name', MyTestTable.Name);
            SubParent.Add('Age', MyTestTable.Age);

            //Defining Child JSON Object
            Child.Add('City Name', MyTestTable.CityName);
            Child.Add('City code', MyTestTable.CityCode);

            SubParent.Add('Associated location', Child);

            ParentArray.Add(SubParent);

            //Clear variables
            Clear(Child);
            Clear(SubParent);

        until MyTestTable.Next = 0;

        Parent.Add('Test', ParentArray);

        //Downloading parent as a json file
        TempBlob.CreateInStream(Instr);
        TempBlob.CreateOutStream(Outstr);
        Parent.WriteTo(Outstr);
        Outstr.WriteText(Data);
        Instr.ReadText(Data);
        FileName := 'MyPracticeJSON.json';
        DownloadFromStream(Instr, 'Downloading !', '', '', FileName);
    end;

    procedure GetJSONFromApi()
    var
        MyHttpClient: HttpClient;
    begin
        // MyHttpClient.Get('https://637e06d39c2635df8f96a44e.mockapi.io/Entities',Response)

    end;
}
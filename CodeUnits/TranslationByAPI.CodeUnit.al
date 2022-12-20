codeunit 50138 TranslationByAPI
{
    procedure GetTranslationsByAPI(var TranslateByAPITable: Record TranslateByAPITable)
    var
        MyHTTPClient: HttpClient;
        HTTPResponse: HttpResponseMessage;
        Request: HttpRequestMessage;
        RecievedHTTPContent: HttpContent;
        RecievedData: Text;
        Headers: HttpHeaders;
        Content: HttpContent;
        //
        MyJSONObj: JsonObject;
        //
        MyJSONObject: JsonObject;
        MyJSONToken: JSONToken;
        //sampl
        TranslArr: JsonArray;
        Object1: JsonObject;
        Token1: JsonToken;
        Object2: JsonObject;
        Token2: JsonToken;
        TranslArr2: JsonArray;
        Token3: JsonToken;
        //
        TextToTranslate: Text;
    begin
        TextToTranslate := TranslateByAPITable.English; 
        Request.Method := 'POST';
        Request.SetRequestUri('https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&from=en&to=ru&to=pa&to=ta&to=te');
        Content.WriteFrom('[{"Text": "' + TextToTranslate + '"}]');
        Content.GetHeaders(Headers);
        Headers.Add('Ocp-Apim-Subscription-Key', 'f3057b4ce1434c6a9b62e18eab3c2055');
        Headers.Add('Ocp-Apim-Subscription-Region', 'westus2');
        Headers.Remove('Content-Type');
        Headers.Add('Content-Type', 'application/json');
        //
        Request.Content(Content);
        MyHTTPClient.Send(Request, HTTPResponse);
        RecievedHTTPContent := HTTPResponse.Content;
        RecievedHTTPContent.ReadAs(RecievedData);
        //
        TranslArr.ReadFrom(RecievedData);
        TranslArr.Get(0, Token1);
        //
        Object1 := Token1.AsObject();
        Object1.Get('translations', Token2);
        TranslArr2 := Token2.AsArray();
        //
        //TranslateByAPITable.Get(EnglishText);
        AssignFieldValues(TranslArr2, TranslateByAPITable);

        //
    end;

    procedure AssignFieldValues(ArrayOfTranslations: JsonArray; var TranslateByAPITable: Record TranslateByAPITable)
    var
        Token: JsonToken;
        ChildToken: JsonToken;
        Object: JsonObject;
        TranslatedLanguageCode: Text;
        TranslatedText: Text;
        Con: Integer;
        temp: Text[500];
    begin
        foreach Token in ArrayOfTranslations do begin
            Object := Token.AsObject();
            // For language code
            Object.Get('to', ChildToken);
            TranslatedLanguageCode := ChildToken.AsValue().AsText();
            // For translated text
            Object.Get('text', ChildToken);
            TranslatedText := ChildToken.AsValue().AsText();
            case TranslatedLanguageCode of

                'ru':
                    begin
                        TranslateByAPITable.Russian := TranslatedText;
                        Con := TranslateByAPITable.Count;
                    end;
                'pa':
                    begin
                        TranslateByAPITable.Punjabi := TranslatedText;
                    end;
                'ta':
                    begin
                        TranslateByAPITable.Tamil := TranslatedText;
                    end;
                'te':
                    begin
                        TranslateByAPITable.Telugu := TranslatedText;
                    end;
            end;
        end;
        TranslateByAPITable.Modify();
    end;

    var
        TranslateByAPITable: Record TranslateByAPITable;
}
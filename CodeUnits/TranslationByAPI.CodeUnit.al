codeunit 50138 TranslationByAPI
{
    procedure GetTranslationsByAPI(var TextToTranslate: Text[1000])
    var
        MyHTTPClient: HttpClient;
        HTTPResponse: HttpResponseMessage;
        Request: HttpRequestMessage;
        RecievedHTTPContent: HttpContent;
        RecievedData: Text;
        Headers: HttpHeaders;
        Content: HttpContent;
        //
        TranslateByAPITable: Record TranslateByAPITable;
        //
        MyJSONObj: JsonObject;
        //
        MyJSONObject: JsonObject;
        MyJSONToken: JSONToken;
        //sampl
        TranslArr: JsonArray;
        Object1: JsonObject;
        Token1: JsonToken;
        // TranslatedStringsJSONToken: JsonToken;
        // TranslatedStrings: Text;
    begin
        Request.Method := 'POST';
        Request.SetRequestUri('https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&from=en&to=ru&to=zh&to=nl&to=de&to=pa&to=ta&to=te&to=hi');
        Content.WriteFrom('[{"Text": "' + TextToTranslate + '"}]');
        Content.GetHeaders(Headers);
        Headers.Add('Ocp-Apim-Subscription-Key', 'f3057b4ce1434c6a9b62e18eab3c2055');
        Headers.Add('Ocp-Apim-Subscription-Region', 'westus2');
        Headers.Remove('Content-Type');
        Headers.Add('Content-Type', 'application/json');
        // Headers.Add('Content-Length', '19');
        // Request.GetHeaders(Headers);
        Request.Content(Content);
        MyHTTPClient.Send(Request, HTTPResponse);
        RecievedHTTPContent := HTTPResponse.Content;
        RecievedHTTPContent.ReadAs(RecievedData);
        //
        TranslArr.ReadFrom(RecievedData);
        MyJSONObj:=TranslArr.AsToken()
        Message(format(TranslArr));
        //
    end;

}
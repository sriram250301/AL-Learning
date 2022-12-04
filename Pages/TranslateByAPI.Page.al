page 50137 TranslateByAPIPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = TranslateByAPITable;
    Caption = 'Translate using API';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(English; English)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        TranslateByAPICodeUnit: Codeunit TranslationByAPI;
                    begin
                        TranslateByAPICodeUnit.GetTranslationsByAPI(English);
                    end;

                }

                field(Russian; Russian)
                {
                    ApplicationArea = All;

                }
                field(Chinese; Chinese)
                {
                    ApplicationArea = All;

                }
                field(Dutch; Dutch)
                {
                    ApplicationArea = All;

                }
                field(German; German)
                {
                    ApplicationArea = All;

                }
                field(Punjabi; Punjabi)
                {
                    ApplicationArea = All;

                }
                field(Tamil; Tamil)
                {
                    ApplicationArea = All;

                }
                field(Telugu; Telugu)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
}
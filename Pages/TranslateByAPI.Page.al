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
                field(English; Rec.English)
                {
                    ApplicationArea = All;

                }
                field(Russian; Rec.Russian)
                {
                    ApplicationArea = All;

                }
                field(Punjabi; Rec.Punjabi)
                {
                    ApplicationArea = All;

                }
                field(Tamil; Rec.Tamil)
                {
                    ApplicationArea = All;

                }
                field(Telugu; Rec.Telugu)
                {
                    ApplicationArea = All;

                }
            }
        }
    }


}
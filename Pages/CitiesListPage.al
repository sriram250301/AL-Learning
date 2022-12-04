page 50104 CitiesListPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = CitiesList;
    Caption = 'Cities list';
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(CityCode; Rec.CityCode)
                {
                    ApplicationArea = All;
                    
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
    
    var
        myInt: Integer;
}
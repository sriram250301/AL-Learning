pageextension 50133 CustomerListExtension extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addfirst(General)
        {
            action("My Query")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    MyQuery: Query MyQuery;
                    MyQueryPage: Page MyQueryPage;
                begin
                    // MyQuery.TopNumberOfRows := 6;
                    MyQuery.Open();
                    while MyQuery.Read() do begin
                        //Message('Liscence type : %1 ,Count : %2', MyQuery.License_Type, MyQuery.Quantity);
                    end;
                    MyQuery.Close();
                end;
            }
        }
    }
}
page 50132 MyQueryPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Customer;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;

                }
                field("Balance Due (LCY)"; Rec."Balance Due (LCY)")
                {
                    ApplicationArea = All;

                }


            }

        }
    }
}

query 50132 MyQuery
{
    QueryType = Normal;
    QueryCategory = 'Customer List';
    Caption = 'My Query';
    // TopNumberOfRows = 4;

    elements
    {
        dataitem(Customer; Customer)
        {
            //The below line of code will display error that filter on Flow field cannot be applied
            // DataItemTableFilter = "Balance Due (LCY)" = filter(0);
            column(Name; Name)
            {
            }
            column(No_; "No.")
            {
            }
            column(Counter)
            {
                Method = Count;
            }
            //We assign filter in this block for fields whose FieldClass is not "Normal" or if its a FlowField
            column(Balance_Due__LCY_; "Balance Due (LCY)")
            {
                ColumnFilter = Balance_Due__LCY_ = filter(> 0);
            }
            dataitem(Sales_Header; "Sales Header")
            {
                DataItemLink = "Sell-to Customer No." = Customer."No.";
                SqlJoinType = InnerJoin;
                column("SalesAmount"; Amount)
                {
                }
            }
        }
    }
}
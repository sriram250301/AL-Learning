report 50138 PurchaseReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'PurchaseReport.rdl';

    dataset
    {

        // dataitem("Company Information"; "Company Information")
        // {
        //     column(Picture; Picture) { }
        // }
        dataitem(PurchaseHeader; "Purchase Header")
        {
            DataItemTableView = where("Document Type" = filter(order));
            //Header
            column(OrderNumber; "No.") { }
            column(CompanyName; CompanyName) { }
            column(TableName; TableName) { }
            column(ReportDate; CurrDate) { }
            //Body
            dataitem(PurchaseLine; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = PurchaseHeader;
                column(No; "No.") { }
                column(Quantity; Quantity) { }
                column(Unit; "Unit of Measure Code") { }
                column(Description; Description) { }
                column(OrderDate; "Order Date") { }
                column(Amount; Amount) { }
                column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
                column(Bin_Code; "Bin Code") { }
                column(Variant_Code; "Variant Code") { }

                trigger OnAfterGetRecord()
                begin
                    TotalRetrievedRecords := TotalRetrievedRecords + 1;
                end;
            }
            dataitem(Blanks; Integer)
            {
                column(ColumnName; Number)
                {

                }
                trigger OnPreDataItem()
                var
                    i: Integer;
                begin
                    Blanks.SetRange(Number, 0, TotalNoOfPossibleRecordsPerPage - TotalRetrievedRecords);
                    TotalRetrievedRecords := 0;
                end;
            }

        }
    }

    trigger OnPreReport()
    begin
        TotalNoOfPossibleRecordsPerPage := 23;
        TotalRetrievedRecords := 0;
    end;

    var
        CurrDate: DateTime;
        TotalNoOfPossibleRecordsPerPage: Integer;
        TotalRetrievedRecords: Integer;
        PurchHeaderTemp: Record "Purchase Header" temporary;


}
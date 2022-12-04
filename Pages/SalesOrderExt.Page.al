pageextension 50123 SalesOrderExt extends "Sales Order List"
{
    actions
    {
        addafter(PostAndSend)
        {
            action("ExportSalesOrder")
            {
                ApplicationArea = All;
                Caption = 'Export Sales Orders';
                trigger OnAction()
                var
                    XMLOperationsCodeUnit: Codeunit SalesOrderXMLOperations;
                begin
                    XMLOperationsCodeUnit.ExportSalesOrder();
                end;
            }
            action("ImportSalesOrder")
            {
                ApplicationArea = All;
                Caption = 'Import Sales Orders';
                trigger OnAction()
                var
                    XMLOperationsCodeUnit: Codeunit SalesOrderXMLOperations;
                begin
                    XMLOperationsCodeUnit.ImportSalesOrder();
                end;
            }
        }

    }

}
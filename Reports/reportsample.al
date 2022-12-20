report 50139 MyReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'MyReport.rdl';

    dataset
    {
        dataitem(MyTestTable; MyTestTable)
        {
            column(ID; ID)
            {

            }
            trigger OnAfterGetRecord()
            begin
                RecordsFromTable := MyTestTable.Count;
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
                // for i := 0 to TotalRecordsPossible - RecordsFromTable do
                //     Blanks.Insert();
                Blanks.SetRange(Number, 0, 27);
            end;
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        TotalRecordsPossible := 10;
    end;

    var
        IntRec: Record Integer;
        TotalRecordsPossible: Integer;
        RecordsFromTable: Integer;
}
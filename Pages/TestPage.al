page 50101 MyTestPage
{
    PageType = List;
    Caption = 'My test page';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = MyTestTable;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General';
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    Caption = 'ID';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = All;
                    Caption = 'Age';
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                    Caption = 'Balance';
                }
                field(CityCode; Rec.CityCode)
                {
                    ApplicationArea = All;
                    Caption = 'CityCode';
                    TableRelation = CitiesList;
                }
                field(CityName; Rec.CityName)
                {
                    ApplicationArea = All;
                    Caption = 'City name';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("Basic")
            {

                action("SetCurrentKey Demo")
                {
                    ApplicationArea = All;
                    Caption = 'SetCurrentKey';
                    ToolTip = 'Sorts the Table in Ascending order with respect to Age';
                    Image = StepInto;

                    trigger OnAction()
                    begin
                        Rec.SetCurrentKey(Age, ID);
                        Rec.SetAscending(Age, true);
                    end;
                }
                action("Lock Table")
                {
                    ApplicationArea = All;
                    Caption = 'Lock Table';
                    ToolTip = 'Locks the Table';
                    Image = Lock;

                    trigger OnAction()
                    var
                        TestTable: Record MyTestTable;
                    begin
                        TestTable.LockTable();
                    end;
                }
                action("Display details")
                {
                    ApplicationArea = All;
                    Caption = 'Display details';
                    ToolTip = 'Displays Names & location in message';
                    Image = ShowList;

                    trigger OnAction()
                    var
                        TestTable: Record MyTestTable;
                    begin
                        TestTable.FindSet();
                        repeat
                            TestTable.CalcFields(CityName);
                            Message('Name : %1 , Location : %2', TestTable.Name, TestTable.CityName);
                        until TestTable.Next() = 0;
                    end;
                }
                action("Total balance")
                {
                    ApplicationArea = All;
                    Caption = 'Total balance';
                    ToolTip = 'Calculates the total available balance by summation of balance of all the records';
                    Image = NewSum;

                    trigger OnAction()
                    var
                        TestTable: Record MyTestTable;
                        TotalBalnceSum: Integer;
                    begin
                        TestTable.FindSet();
                        TestTable.CalcSums(Balance);
                        Message('%1', TestTable.Balance);
                        TestTable.Get();

                    end;
                }
                action("Reset")
                {
                    ApplicationArea = All;
                    Caption = 'Reset';
                    ToolTip = 'Removes all filters assigned to a table if any';
                    Image = Restore;

                    trigger OnAction()
                    begin
                        Rec.Reset();
                    end;
                }
                action("Count Records")
                {
                    ApplicationArea = All;
                    Caption = 'Count Records';
                    ToolTip = 'Counts records of a table';
                    Image = CalculateCalendar;

                    trigger OnAction()
                    var
                        NoOfRecords: Integer;
                    begin
                        if Rec.IsEmpty then
                            Message('Table is empty!')
                        else
                            NoOfRecords := Rec.Count;
                        Message('Records in the table : %1', NoOfRecords);
                    end;
                }
                action("Set Rec Filter")
                {
                    ApplicationArea = All;
                    Caption = 'Set Rec Filter';
                    ToolTip = 'Set Rec Filter demonstration';
                    Image = EditFilter;

                    trigger OnAction()
                    var
                        TestTable: Record MyTestTable;
                        TestTable1: Record MyTestTable;
                    begin
                        TestTable.FindLast();
                        //TestTable.SetCurrentKey(Name);
                        TestTable.SetRecFilter();
                        Message('Filter applied here is : %1', TestTable.GetFilters);
                        TestTable1.SetFilter(ID, TestTable.GetFilter(ID));
                        TestTable1.FindFirst();
                        Message('Filter applied here is : %1', TestTable1.GetFilters);

                    end;

                }
            }
            group("XML & JSON")
            {
                action("Export as XML")
                {
                    ApplicationArea = All;
                    Caption = 'Export as XML';
                    ToolTip = 'Exports the records in xml format';
                    Image = Export;

                    trigger OnAction()
                    var
                        XMLOperations: Codeunit XMLOperations;

                    begin
                        XMLOperations.ExportAsXML();
                    end;
                }
                action("Import as XML")
                {
                    ApplicationArea = All;
                    Caption = 'Import as XML';
                    ToolTip = 'Imports the records in xml format';
                    Image = Import;

                    trigger OnAction()
                    var
                        XMLOperations: Codeunit XMLOperations;

                    begin
                        XMLOperations.ImportasXML();
                    end;
                }
                action("Export as JSON")
                {
                    ApplicationArea = All;
                    Caption = 'Export as JSON';
                    ToolTip = 'Exports the records of the table as .JSON file';
                    Image = Export;
                    trigger OnAction()
                    var
                    JSONOperations: Codeunit JSONPractice;
                    begin
                        JSONOperations.ExportJSONPractice();
                    end;
                }
                action("Get data by API")
                {
                    ApplicationArea = All;
                    Caption = 'Get data by API';
                    ToolTip = 'Fetches data from HTTP Client and displays as a message';
                    Image = Import;
                    trigger OnAction()
                    var
                    //JSONOperations: Codeunit JSONPractice;
                    begin
                        //Message(JSONOperations.GetJSONFromApi());
                    end;
                }
                action("Import as JSON")
                {
                    ApplicationArea = All;
                    Caption = 'Import as JSON';
                    ToolTip = 'Fetches data from HTTP Client and inserts as  a record in table';
                    Image = Import;
                    trigger OnAction()
                    var
                    //JSONOperations: Codeunit JSONPractice;
                    begin
                        //JSONOperations.ImportAsJSON();
                    end;
                    
                }
                action("Lets Translate !")
                {
                    ApplicationArea = All;
                    Caption = 'Lets translate!';
                    ToolTip = 'Fetches translated data using API';
                    Image = Translate;
                    trigger OnAction()
                    var
                        TranslationsPage: Page TranslateByAPIPage;
                        
                    begin
                        TranslationsPage.Run();
                    end;
                    
                }

            }
        }
    }
}
table 50103 CitiesList
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;CityCode; Code[10])
        {
            DataClassification = ToBeClassified;
            
        }
        field(2;Name; Text[50])
        {
            DataClassification = ToBeClassified;
            
        }
    }
    
    keys
    {
        key(PK; CityCode)
        {
            Clustered = true;
        }
    }
    
    var
        myInt: Integer;
        Recd: Record MyTestTable;
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}
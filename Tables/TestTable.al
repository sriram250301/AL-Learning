table 50102 MyTestTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(2; Name; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; Age; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(4; CityCode; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(5; CityName; Text[50])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = LOOKUP(CitiesList.Name WHERE(CityCode = field(CityCode)));
        }
        field(6; Balance; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; ID, Balance)
        {
            Clustered = true;
        }
    }

}
table 50136 TranslateByAPITable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; English; Text[500])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Russian; Text[500])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; Punjabi; Text[500])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; Tamil; Text[500])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; Telugu; Text[500])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(PK; English)
        {
            Clustered = true;
        }
    }



}
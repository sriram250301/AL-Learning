table 50136 TranslateByAPITable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; English; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Russian; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; Chinese; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; Dutch; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; German; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; Punjabi; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; Tamil; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; Telugu; Text[50])
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
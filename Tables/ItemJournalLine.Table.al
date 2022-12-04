tableextension 50121 ItemJournalLineExtension extends "Item Journal Line"
{
    fields
    {
        field(50111; QualityChecked; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50112; TaxPercentage; Integer)
        {
            DataClassification = CustomerContent;
        }
        
    }
}
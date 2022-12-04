tableextension 50116 ItemLedgerEntryExtension extends "Item Ledger Entry"
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
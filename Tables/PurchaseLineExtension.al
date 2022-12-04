tableextension 50109 PurchaseLineExtension extends "Purchase Line"
{
    fields
    {
        field(50111;QualityChecked;Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50112;TaxPercentage;Integer)
        {
            DataClassification = CustomerContent;
        }
    }
    
}
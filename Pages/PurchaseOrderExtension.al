pageextension 50113 PurchaseLineExtension extends "Purchase Order Subform"
{
    
    layout
    {
        addafter("No.")
        {
            field(QualityChecked;Rec.QualityChecked)
            {
                ApplicationArea= all;
                Caption = 'Quality checked';
            }
            field(TaxPercentage;Rec.TaxPercentage)
            {
                ApplicationArea= all;
                Caption = 'Tax percentage %';
            }
        }
    }
}
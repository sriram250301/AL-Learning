pageextension 50119 ItemLedgerEntriesExtension extends "Item Ledger Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field(QualityChecked; Rec.QualityChecked)
            {
                ApplicationArea = all;
                Caption = 'Quality checked';
            }
            field(TaxPercentage; Rec.TaxPercentage)
            {
                ApplicationArea = all;
                Caption = 'Tax percentage';
            }
        }
    }
}
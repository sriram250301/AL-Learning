codeunit 50120 MySubscriptionEvent
{
    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromPurchLine', '', false, false)]
    local procedure MyProcedure(PurchLine: Record "Purchase Line"; var ItemJnlLine: Record "Item Journal Line")
    begin
        ItemJnlLine.QualityChecked := PurchLine.QualityChecked;
        ItemJnlLine.TaxPercentage := PurchLine.TaxPercentage;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Ledger Entry", 'OnAfterCopyTrackingFromItemJnlLine', '', false, false)]
    local procedure MyProcedure1(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJnlLine: Record "Item Journal Line")
    begin
        ItemLedgerEntry.QualityChecked := ItemJnlLine.QualityChecked;
        ItemLedgerEntry.TaxPercentage := ItemJnlLine.TaxPercentage;
    end;

}
pageextension 52107 "HMP Released Production Order" extends "Released Production Order"
{
    actions
    {
        addlast("&Print")
        {
            action("HMP Routing Sheet")
            {
                ApplicationArea = all;
                Image = Report;
                Ellipsis = true;

                trigger OnAction()
                var
                    RoutingSheet: Report "HMP Routing Sheet";
                    ProdOrderLineRecLcl: Record "Prod. Order Line";
                begin
                    ProdOrderLineRecLcl.Reset();
                    ProdOrderLineRecLcl.SetRange(Status, rec.Status);
                    ProdOrderLineRecLcl.SetRange("Prod. Order No.", rec."No.");
                    if ProdOrderLineRecLcl.FindFirst() then begin
                        RoutingSheet.SetProductionOrder(ProdOrderLineRecLcl);
                        RoutingSheet.RunModal();
                    end;
                end;
            }
        }
    }
}

pageextension 52100 "Posted Sales Shipment Extends" extends "Posted Sales Shipment"
{
    actions
    {
        addafter("&Print")
        {
            action("HMP CertificateOfCompliance")
            {
                ApplicationArea = All;
                Caption = 'Certificate Of Compliance';
                Image = Print;

                trigger OnAction()
                var
                    PostedSalesShipment: Record "Sales Shipment Header";
                begin
                    CurrPage.SetSelectionFilter(PostedSalesShipment);
                    Report.RunModal(Report::"HMP Certificate Of Compliance", true, false, PostedSalesShipment);
                end;
            }
        }
    }
}

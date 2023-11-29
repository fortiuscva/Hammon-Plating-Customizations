report 52103 "HMP Certificate Of Compliance"
{
    Caption = 'HMP Certificate Of Compliance';
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/CertificateOfCompliance.rdl';
    dataset
    {
        dataitem(SalesShipmentHeader; "Sales Shipment Header")
        {
            RequestFilterFields = "No.";
            column(SalesShipmentHeader_No; "No.")
            { }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where(Type = const(Item), Quantity = filter(> 0));
                RequestFilterFields = "No.";
                column(gRecCompanyInfo_Picture; CompanyInformation.Picture)
                { }
                column(CompanyAddress1; CompanyAddress[1])
                { }
                column(CompanyAddress2; CompanyAddress[2])
                { }
                column(CompanyAddress3; CompanyAddress[3])
                { }
                column(CompanyAddress4; CompanyAddress[4])
                { }
                column(CompanyAddress5; CompanyAddress[5])
                { }
                column(CompanyAddress6; CompanyAddress[6])
                { }
                column(CompanyAddress7; CompanyAddress[7])
                { }
                column(CompanyAddress8; CompanyAddress[8])
                { }
                column(Certificate_Of_Comp_Caption; Certificate_Of_Comp_CaptionLbl)
                { }
                column(Customer_Caption; Customer_CaptionLbl)
                { }
                column(SalesShipmentHeader_CustName; SalesShipmentHeader."Sell-to Customer Name")
                { }
                column(Certification_Date_Caption; Certification_Date_CaptionLbl)
                { }
                column(SalesShipmentHeader_PostDate; SalesShipmentHeader."Posting Date")
                { }
                column(HardcodedText; HardcodedText_Lbl)
                { }
                column(Purchase_Order_No_Caption; Purchase_Order_No_CaptionLbl)
                { }
                column(PurchaseOrderNoValue; SalesShipmentHeader."External Document No.")
                { }
                column(WO_No_Caption; WO_No_CaptionLbl)
                { }
                column(WorkOrderNoValue; "Sales Shipment Line"."Order No.")
                { }
                column(Part_Number_Caption; Part_Number_CaptionLbl)
                { }
                column(No_; "No.")
                { }
                column(Description_Caption; Description_CaptionLbl)
                { }
                column(Description; Description)
                { }
                column(Revision_Caption; Revision_CaptionLbl)
                { }
                column(RevisionValue; RevisionValue)
                { }
                column(Qty_Caption; Qty_CaptionLbl)
                { }
                column(Quantity; Quantity)
                { }
                column(Planting_Spec_Caption; Planting_Spec_CaptionLbl)
                { }

                column(Jeff_Caption; Jeff_CaptionLbl)
                { }
                column(QM_Caption; QM_CaptionLbl)
                { }
                dataitem("Extended Text Line"; "Extended Text Line")
                {
                    DataItemLink = "No." = field("No.");
                    DataItemLinkReference = "Sales Shipment Line";
                    DataItemTableView = sorting("Table Name", "No.", "Language Code", "Text No.", "Line No.");
                    column(ExtendText_Line_No_; "Line No.")
                    { }
                    column(ExtendText_Text; Text)
                    { }
                    column(ExtendText_Text_No_; "Text No.")
                    { }

                    trigger OnPreDataItem()
                    begin
                        SetRange("Language Code", Language.GetUserLanguageCode());
                    end;
                }
                dataitem(ItemTrackingSpec; Integer)
                {
                    DataItemTableView = sorting(Number);
                    DataItemLinkReference = "Sales Shipment Line";
                    column(TempItemLedgEntry_ItemNo; TempTrackingSpecBuffer."Item No.")
                    { }
                    column(TempItemLedgEntry_LotNo; LotNo)
                    { }
                    column(Tracking_Number; Number)
                    { }
                    column(TempTrackingSpecBuffer_Qty; TempTrackingSpecBuffer."Quantity (Base)")
                    { }
                    column(Serial_Caption; Serial_CaptionLbl)
                    { }
                    trigger OnAfterGetRecord()
                    begin
                        if Number = 1 then begin
                            TempTrackingSpecBuffer.FindSet();
                            LotNo := TempTrackingSpecBuffer."Serial No.";
                        end else begin
                            TempTrackingSpecBuffer.Next();
                            LotNo := TempTrackingSpecBuffer."Serial No.";
                        end;
                    end;

                    trigger OnPreDataItem()
                    begin
                        TempTrackingSpecBuffer.SetRange("Source Ref. No.", "Sales Shipment Line"."Line No.");
                        if TempTrackingSpecBuffer.Count = 0 then
                            CurrReport.Break();
                        SetRange(Number, 1, TempTrackingSpecBuffer.Count);
                    end;
                }

                //Shipment Line Trigger Start
                trigger OnAfterGetRecord()
                begin
                    Clear(RevisionValue);
                    Clear(ItemAttribute);
                    Clear(ItemAttributeValueMapping);
                    Clear(ItemAttributeValue);

                    ItemAttribute.SetFilter(Name, '=%1', 'Revision');
                    if ItemAttribute.FindFirst() then
                        if ItemAttributeValueMapping.Get(Database::Item, "Sales Shipment Line"."No.", ItemAttribute.ID) then begin
                            if ItemAttributeValue.Get(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID") then
                                RevisionValue := ItemAttributeValue.Value;
                        end;

                    GetSerialLotNo("Sales Shipment Line");
                end;

                //Shipment Line Trigger End
            }

            //Header Trigger Start
            trigger OnAfterGetRecord()
            begin
                FormatAddress.Company(CompanyAddress, CompanyInformation);
                CompanyAddress[9] := CompanyInformation."Phone No.";
                CompanyAddress[10] := CompanyInformation."Fax No.";
            end;
            //Header Trigger End
        }
    }

    trigger OnInitReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;

    local procedure GetSerialLotNo(TempSalesShipmentLine: Record "Sales Shipment Line" temporary)
    var
        ItemTrackDocMgmt: Codeunit "Item Tracking Doc. Management";
    begin
        Clear(TempTrackingSpecBuffer);
        TempTrackingSpecBuffer.DeleteAll();

        ItemTrackDocMgmt.RetrieveDocumentItemTracking(TempTrackingSpecBuffer, SalesShipmentHeader."No.", DATABASE::"Sales Shipment Header", 0);
    end;

    var
        CompanyInformation: Record "Company Information";
        ItemAttributeValueSelection: Record "Item Attribute Value Selection";
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        ItemAttribute: Record "Item Attribute";
        ItemAttributeValue: Record "Item Attribute Value";
        Language: Codeunit Language;
        CompanyAddress: array[10] of Text[100];
        FormatAddress: Codeunit "Format Address";
        Certificate_Of_Comp_CaptionLbl: Label 'Certificate Of Compliance';
        HardcodedText_Lbl: Label 'Hammon Plating hereby certifies that the part number listed below has been processed in accordance with all of the purchase order, drawing and other specified requirements. All materials conform to Quality Control & Calibration System and Inspection requirements per ISO 9001 and AS9100 and all other standards applicable to electroplating';
        Customer_CaptionLbl: Label 'Customer:';
        Certification_Date_CaptionLbl: Label 'Certification Date:';
        Purchase_Order_No_CaptionLbl: Label 'Purchase Order:';
        Part_Number_CaptionLbl: Label 'Part Number:';
        Description_CaptionLbl: Label 'Description:';
        WO_No_CaptionLbl: Label 'Work Order:';
        Revision_CaptionLbl: Label 'Revision:';
        Qty_CaptionLbl: Label 'Quantity:';
        Planting_Spec_CaptionLbl: Label 'Plating Spec:';
        Serial_CaptionLbl: Label 'Serial Number';
        Jeff_CaptionLbl: Label 'Jeff Yee';
        QM_CaptionLbl: Label 'Quality Manager';
        TempTrackingSpecBuffer: Record "Tracking Specification" temporary;
        LotNo: Text;
        RevisionValue: Text;

}

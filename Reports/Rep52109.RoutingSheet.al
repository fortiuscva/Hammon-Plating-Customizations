report 52109 "HMP Routing Sheet"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/RoutingSheet.rdl';
    AdditionalSearchTerms = 'operations sheet,process structure sheet';
    ApplicationArea = all;
    Caption = 'HMP Routing Sheet';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(No_Item; "No.")
            {
            }
            column(PrintComment; PrintComment)
            {
            }
            column(PrintTool; PrintTool)
            {
            }
            column(PrintPersonnel; PrintPersonnel)
            {
            }
            column(PrintQualityMeasures; PrintQualityMeasures)
            {
            }
            column(BarcodeString; BarcodeString)
            {
            }
            column(NoProdOrderRecGbl; ProdOrderLineRecGbl."Prod. Order No.")
            {

            }
            dataitem(Counter1; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(Counter2; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    PrintOnlyIfDetail = true;
                    column(CompanyName; COMPANYPROPERTY.DisplayName())
                    {
                    }
                    column(TodayFormatted; Format(Today))
                    {
                    }
                    column(CopyNo1; CopyNo - 1)
                    {
                    }
                    column(CopyText; CopyText)
                    {
                    }
                    column(No01_Item; Item."No.")
                    {
                    }
                    column(Desc_Item; Item.Description)
                    {
                    }
                    column(ProductionQuantity; ProductionQuantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(RtngNo_Item; Item."Routing No.")
                    {
                    }
                    column(ActiveVersionCode; ActiveVersionCode)
                    {
                    }
                    column(ActiveVersionText; ActiveVersionText)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                    {
                    }
                    column(RoutingSheetCaption; RoutingSheetCaptionLbl)
                    {
                    }
                    column(ProductionQuantityCaption; ProductionQuantityCaptionLbl)
                    {
                    }
                    column(ItemRtngNoCaption; ItemRtngNoCaptionLbl)
                    {
                    }
                    column(DescriptionCaption; DescriptionCaptionLbl)
                    {
                    }
                    column(ProductionOrderCaption; ProductionOrderCaptionLbl)
                    {

                    }
                    column(SalesOrderCaption; SalesOrderCaptionLbl)
                    {

                    }
                    column(CustomerCaption; CustomerCaptionLbl)
                    {

                    }
                    dataitem("Item Attribute Value Mapping"; "Item Attribute Value Mapping")
                    {
                        DataItemTableView = sorting("Table ID", "No.", "Item Attribute ID");
                        DataItemLinkReference = Item;
                        DataItemLink = "No." = field("No.");
                        column(No_; "No.")
                        {

                        }
                        column(Item_Attribute_ID; "Item Attribute ID")
                        {

                        }
                        column(ItemAttributeValue; ItemAttributeValue.Value)
                        {

                        }
                        column(ItemAttributeName; ItemAttributeValue."Attribute Name")
                        {

                        }
                        column(ItemAttributeValueSelectionUOM; ItemAttribute."Unit of Measure")
                        {

                        }
                        trigger OnAfterGetRecord()
                        begin
                            if ItemAttributeValue.Get("Item Attribute Value Mapping"."Item Attribute ID", "Item Attribute Value Mapping"."Item Attribute Value ID") then begin
                                ItemAttributeValue.CalcFields("Attribute Name");

                                if ItemAttribute.Get(ItemAttributeValue."Attribute ID") then;
                            end;
                        end;
                    }
                    dataitem("Routing Header"; "Routing Header")
                    {
                        DataItemTableView = SORTING("No.");
                        PrintOnlyIfDetail = true;
                        dataitem("Routing Line"; "Routing Line")
                        {
                            DataItemLink = "Routing No." = FIELD("No.");
                            DataItemTableView = SORTING("Routing No.", "Version Code", "Operation No.");
                            column(OperationNo_RtngLine; "Operation No.")
                            {
                                IncludeCaption = true;
                            }
                            column(Type_RtngLine; Type)
                            {
                                IncludeCaption = true;
                            }
                            column(No_RtngLine; "No.")
                            {
                                IncludeCaption = true;
                            }
                            column(SendAheadQty_RtngLine; "Send-Ahead Quantity")
                            {
                                IncludeCaption = true;
                            }
                            column(SetupTime_RtngLine; "Setup Time")
                            {
                                IncludeCaption = true;
                            }
                            column(RunTime_RtngLine; "Run Time")
                            {
                                IncludeCaption = true;
                            }
                            column(MoveTime_RtngLine; "Move Time")
                            {
                                IncludeCaption = true;
                            }
                            column(TotalTime; TotalTime)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(RunTimeUOMCode_RtngLine; "Run Time Unit of Meas. Code")
                            {
                            }
                            column(ScrapFactor_RtngLine; "Scrap Factor %")
                            {
                                IncludeCaption = true;
                            }
                            column(WaitTime_RtngLine; "Wait Time")
                            {
                                IncludeCaption = true;
                            }
                            column(TotalTimeCaption; TotalTimeCaptionLbl)
                            {
                            }
                            column(RtngLnRunTimeUOMCodeCptn; RtngLnRunTimeUOMCodeCptnLbl)
                            {
                            }
                            column(Description; Description)
                            {

                            }
                            dataitem("Routing Comment Line"; "Routing Comment Line")
                            {
                                DataItemLink = "Routing No." = FIELD("Routing No."), "Version Code" = FIELD("Version Code"), "Operation No." = FIELD("Operation No.");
                                DataItemTableView = SORTING("Routing No.", "Version Code", "Operation No.", "Line No.");
                                column(LineComment_RtngComment; RoutingComment)
                                {
                                }
                                trigger OnAfterGetRecord()
                                var
                                    NonUnderlineComment: Text;
                                    UnderlineCommentFound: Boolean;
                                begin
                                    if copystr(Comment, 1, 1) <> '_' then
                                        Comment := '';


                                    Clear(NonUnderlineComment);
                                    clear(UnderlineCommentFound);
                                    clear(RoutingComment);
                                    RoutinCommentLine.Reset();
                                    RoutinCommentLine.SetRange("Routing No.", "Routing Comment Line"."Routing No.");
                                    RoutinCommentLine.SetRange("Version Code", "Routing Comment Line"."Version Code");
                                    RoutinCommentLine.SetRange("Operation No.", "Routing Comment Line"."Operation No.");
                                    RoutinCommentLine.SetFilter("Line No.", '>%1', "Routing Comment Line"."Line No.");
                                    if RoutinCommentLine.FindSet() then
                                        repeat
                                            if not UnderlineCommentFound and (copystr(RoutinCommentLine.Comment, 1, 1) <> '_') then
                                                NonUnderlineComment += RoutinCommentLine.Comment
                                            else
                                                UnderlineCommentFound := true;
                                        until RoutinCommentLine.Next() = 0;
                                    if Comment <> '' then
                                        RoutingComment := Comment + NonUnderlineComment;
                                end;

                                trigger OnPreDataItem()
                                begin
                                    SetRange("Routing No.", Item."Routing No.");
                                    if not PrintComment then
                                        CurrReport.Break();
                                end;
                            }
                            dataitem("Routing Tool"; "Routing Tool")
                            {
                                DataItemLink = "Routing No." = FIELD("Routing No."), "Version Code" = FIELD("Version Code"), "Operation No." = FIELD("Operation No.");
                                DataItemTableView = SORTING("Routing No.", "Version Code", "Operation No.", "Line No.");
                                column(Desc_RtngTool; Description)
                                {
                                }
                                column(No_RtngTool; "No.")
                                {
                                }

                                trigger OnPreDataItem()
                                begin
                                    if not PrintTool then
                                        CurrReport.Break();
                                end;
                            }
                            dataitem("Routing Personnel"; "Routing Personnel")
                            {
                                DataItemLink = "Routing No." = FIELD("Routing No."), "Version Code" = FIELD("Version Code"), "Operation No." = FIELD("Operation No.");
                                DataItemTableView = SORTING("Routing No.", "Version Code", "Operation No.", "Line No.");
                                column(Desc_RtngPersonnel; Description)
                                {
                                }
                                column(No_RtngPersonnel; "No.")
                                {
                                }

                                trigger OnPreDataItem()
                                begin
                                    if not PrintPersonnel then
                                        CurrReport.Break();
                                end;
                            }
                            dataitem("Routing Quality Measure"; "Routing Quality Measure")
                            {
                                DataItemLink = "Routing No." = FIELD("Routing No."), "Version Code" = FIELD("Version Code"), "Operation No." = FIELD("Operation No.");
                                DataItemTableView = SORTING("Routing No.", "Version Code", "Operation No.", "Line No.");
                                column(Desc_RtngQualityMeasure; Description)
                                {
                                }
                                column(QMCode_RtngQltyMeasure; "Qlty Measure Code")
                                {
                                }

                                trigger OnPreDataItem()
                                begin
                                    if not PrintQualityMeasures then
                                        CurrReport.Break();
                                end;
                            }

                            trigger OnAfterGetRecord()
                            var
                                RunTimeFactor: Decimal;
                            begin
                                RunTimeFactor := CalendarMgt.TimeFactor("Run Time Unit of Meas. Code");
                                TotalTime :=
                                  Round(
                                    "Setup Time" * CalendarMgt.TimeFactor("Setup Time Unit of Meas. Code") / RunTimeFactor +
                                    "Wait Time" * CalendarMgt.TimeFactor("Wait Time Unit of Meas. Code") / RunTimeFactor +
                                    "Move Time" * CalendarMgt.TimeFactor("Move Time Unit of Meas. Code") / RunTimeFactor +
                                    ProductionQuantity * "Run Time", UOMMgt.TimeRndPrecision());
                            end;

                            trigger OnPreDataItem()
                            begin
                                if ActiveVersionCode <> '' then
                                    SetFilter("Version Code", ActiveVersionCode)
                                else
                                    SetFilter("Version Code", '%1', '');
                            end;
                        }

                        trigger OnPreDataItem()
                        begin
                            SetRange("No.", Item."Routing No.");
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    if CopyNo = LoopNo then
                        CurrReport.Break();

                    CopyNo := CopyNo + 1;

                    if CopyNo = 1 then
                        Clear(CopyText)
                    else begin
                        CopyText := Text000;
                        OutputNo += 1;
                    end;
                end;

                trigger OnPreDataItem()
                var

                    BarcodeSymbology: Enum "Barcode Symbology";
                    BarcodeFontProvider: Interface "Barcode Font Provider";
                begin
                    if NumberOfCopies = 0 then
                        LoopNo := 1
                    else
                        LoopNo := 1 + NumberOfCopies;
                    CopyNo := 0;
                    OutputNo := 1;

                    BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                    BarcodeSymbology := Enum::"Barcode Symbology"::"Code39";
                    BarcodeFontProvider.ValidateInput(ProdOrderLineRecGbl."Prod. Order No.", BarcodeSymbology);
                    BarcodeString := BarcodeFontProvider.EncodeFont(ProdOrderLineRecGbl."Prod. Order No.", BarcodeSymbology);


                end;
            }
            trigger OnAfterGetRecord()
            begin
                if "Routing No." = '' then
                    CurrReport.Skip();

                ActiveVersionCode :=
                  VersionMgt.GetRtngVersion("Routing No.", WorkDate(), true);

                if ActiveVersionCode <> '' then
                    ActiveVersionText := Text001
                else
                    ActiveVersionText := '';
            end;

            trigger OnPreDataItem()
            begin
                if ProdOrderLineRecGbl."Item No." <> '' then
                    SetRange("No.", ProdOrderLineRecGbl."Item No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ProductionQuantity; ProductionQuantity)
                    {
                        ApplicationArea = all;
                        Caption = 'Production Quantity';
                        DecimalPlaces = 0 : 5;
                        MinValue = 0;
                        ToolTip = 'Specifies the quantity of items to manufacture for which you want the program to calculate the total time of the routing.';
                    }
                    field(PrintComment; PrintComment)
                    {
                        ApplicationArea = all;
                        Caption = 'Comment';
                        ToolTip = 'Specifies whether to include comments that provide additional information about the operation. For example, comments might mention special conditions for completing the operation.';
                    }
                    field(PrintTool; PrintTool)
                    {
                        ApplicationArea = all;
                        Caption = 'Tools';
                        ToolTip = 'Specifies whether to include the tools that are required to complete the operation.';
                    }
                    field(PrintPersonnel; PrintPersonnel)
                    {
                        ApplicationArea = all;
                        Caption = 'Personnel';
                        ToolTip = 'Specifies whether to include the people to involve in the operation. For example, this is useful if the operation requires special knowledge or training.';
                    }
                    field(PrintQualityMeasures; PrintQualityMeasures)
                    {
                        ApplicationArea = all;
                        Caption = 'Quality Measures';
                        ToolTip = 'Specifies whether to include quality measures for the operation. For example, this is useful for quality control purposes.';
                    }
                    field(NumberOfCopies; NumberOfCopies)
                    {
                        ApplicationArea = all;
                        Caption = 'No. of Copies';
                        MinValue = 0;
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        ProductionQuantity := 1;
    end;

    var
        ItemAttributeValue: Record "Item Attribute Value";
        ItemAttribute: Record "Item Attribute";
        RoutinCommentLine: Record "Routing Comment Line";
        VersionMgt: Codeunit VersionManagement;
        CalendarMgt: Codeunit "Shop Calendar Management";
        UOMMgt: Codeunit "Unit of Measure Management";
        ProdOrderLineRecGbl: Record "Prod. Order Line";
        BarcodeString: Text;
        NumberOfCopies: Integer;
        CopyNo: Integer;
        CopyText: Text[30];
        ActiveVersionText: Text[30];
        LoopNo: Integer;
        ProductionQuantity: Decimal;
        PrintComment: Boolean;
        PrintTool: Boolean;
        PrintPersonnel: Boolean;
        PrintQualityMeasures: Boolean;
        TotalTime: Decimal;
        ActiveVersionCode: Code[20];
        RoutingComment: Text;

        Text000: Label 'Copy number:';
        Text001: Label 'Active Version';
        OutputNo: Integer;
        CurrReportPageNoCaptionLbl: Label 'Page';
        RoutingSheetCaptionLbl: Label 'Routing Sheet';
        ProductionQuantityCaptionLbl: Label 'Production Quantity';
        ItemRtngNoCaptionLbl: Label 'Routing No.';
        TotalTimeCaptionLbl: Label 'Total Time';
        RtngLnRunTimeUOMCodeCptnLbl: Label 'Time Unit';
        DescriptionCaptionLbl: label 'Description';
        ProductionOrderCaptionLbl: Label 'Production Order #:';
        SalesOrderCaptionLbl: Label 'Sales Order #:';
        CustomerCaptionLbl: Label 'Customer:';

    procedure SetProductionOrder(ProductionOrderLine: Record "Prod. Order Line")
    begin
        ProdOrderLineRecGbl := ProductionOrderLine;
    end;
}


codeunit 52101 "HMP General Functions"
{

    procedure GetItemType(pItemNo: Code[20]): Text;
    var
        ItemRecLcl: Record Item;
    begin
        if ItemRecLcl.get(pItemNo) then
            exit(Format(ItemRecLcl.Type));

        exit('');
    end;

}
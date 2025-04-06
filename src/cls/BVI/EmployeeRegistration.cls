Class BVI.EmployeeRegistration Extends %RegisteredObject
{

ClassMethod Main()
{
    Do ..DisplayHeader()
    Set state = 0  // 0: Employee Number, 1: NameKanji, 2: NameKana, 3: Address
    Set employee = ""
    
    While 1 {
        Set cmd = ..GetInput(state, .employee)
        Quit:cmd="＄"
        
        If cmd="@" {
            Do ..SaveEmployee(.employee)
            Set state = 0
        }
        ElseIf cmd="DEL" {
            Do ..DeleteEmployee(.employee)
            Set state = 0
        }
        ElseIf cmd="/" {
            Set state = $SELECT(state>0:state-1, 1:0)
        }
        ElseIf cmd="//" {
            Set state = 0
        }
        Else {
            Set state = ..ProcessState(state, cmd, .employee)
        }
    }
    Write !,"Program terminated.",!
}

ClassMethod DisplayHeader()
{
    Write !,"===================================="
    Write !,"    Employee Registration Program   "
    Write !,"====================================",!
}

ClassMethod GetInput(state As %Integer, ByRef employee) As %String
{
    Set prompt = $CASE(state,
        0: "社員番号 (4桁未満の数字): ",
        1: "氏名漢字 (全角): ",
        2: "氏名カナ (半角カナ): ",
        3: "住所 (全角): ",
        : "コマンド入力 [@=保存, DEL=削除, /=上, //=最初, ＄=終了]: ")
    
    Write !,prompt
    Read input
    Return input
}

ClassMethod ProcessState(state As %Integer, input As %String, ByRef employee) As %Integer
{
    If state=0 {
        If '##class(BVI.Employee).ValidateEmployeeNumber(input) {
            Write !,"無効な社員番号!",!
            Return 0
        }
        Set employee = ##class(BVI.Employee).EmpNumIndexOpen(input)
        If '$ISOBJECT(employee) {
            Set employee = ##class(BVI.Employee).%New()
            Set employee.EmployeeNumber = input
        }
        Else {
            Write !,"既存のレコードを読み込みました:",!
            Do ..DisplayEmployee(employee)
        }
        Return 1
    }
    ElseIf state=1 {
        If '##class(BVI.Employee).ValidateZenkaku(input) {
            Write !,"無効な漢字入力!",!
            Return 1
        }
        Set employee.NameKanji = input
        Return 2
    }
    ElseIf state=2 {
        If '##class(BVI.Employee).ValidateHankaku(input) {
            Write !,"無効なカナ入力!",!
            Return 2
        }
        Set employee.NameKana = input
        Return 3
    }
    ElseIf state=3 {
        If '##class(BVI.Employee).ValidateZenkaku(input) {
            Write !,"無効な住所入力!",!
            Return 3
        }
        Set employee.Address = input
        Return 4
    }
    Return state
}

ClassMethod SaveEmployee(ByRef employee As BVI.Employee)
{
    If $ISOBJECT(employee) {
        Set status = employee.%Save()
        If $$$ISOK(status) {
            Write !,"保存成功!",!
            Do ..DisplayEmployee(employee)
        }
        Else {
            Write !,"保存エラー: ",$SYSTEM.Status.GetErrorText(status),!
        }
    }
    Else {
        Write !,"保存するデータがありません!",!
    }
}

ClassMethod DeleteEmployee(ByRef employee As BVI.Employee)
{
    If $ISOBJECT(employee) && (employee.%Id()'="") {
        Set status = employee.%DeleteId(employee.%Id())
        If $$$ISOK(status) {
            Write !,"削除成功!",!
        }
        Else {
            Write !,"削除エラー: ",$SYSTEM.Status.GetErrorText(status),!
        }
    }
    Else {
        Write !,"削除対象がありません!",!
    }
}

ClassMethod DisplayEmployee(emp As BVI.Employee)
{
    Write !,"社員番号: ",emp.EmployeeNumber
    Write !,"氏名漢字: ",emp.NameKanji
    Write !,"氏名カナ: ",emp.NameKana
    Write !,"住所: ",emp.Address,!
}

}

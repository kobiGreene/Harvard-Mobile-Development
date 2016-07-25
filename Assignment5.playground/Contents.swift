//: Playground - noun: a place where people can play
// Help From Section

func isLeap(year:Int) -> Bool {
    return year % 4 == 0 ? year % 100 == 0 ? year % 400 == 0 ? true : false : true : false
}
isLeap(1960)
isLeap(1900)
isLeap(2000)

var months = [0,31,28,31,30,31,30,31,31,30,31,30,31]
func julianDate(year: Int, month: Int, day: Int) -> Int{
    let daysInMonth = (0..<month).map({isLeap(year) && $0 == 2 ? 29 : months[$0]}).reduce(0, combine: {$0 + $1})
    let daysInYear = (1900..<year).map({year != 1900 ? (isLeap($0) ? 366 : 365) : 0}).reduce(0, combine: {$0 + $1})
    return daysInYear + daysInMonth + day
}
julianDate(1960, month:  9, day: 28)
julianDate(1900, month:  1, day: 1)
julianDate(1900, month: 12, day: 31)
julianDate(1901, month: 1, day: 1)
julianDate(1901, month: 1, day: 1) - julianDate(1900, month: 1, day: 1)
julianDate(2001, month: 1, day: 1) - julianDate(2000, month: 1, day: 1)

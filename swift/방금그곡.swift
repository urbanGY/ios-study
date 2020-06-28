import Foundation

var elem:[String] = ["C","C#","D","D#","E","F","F#","G","G#","A","A#","B"]
var index:Int = 0
var map:[String:String] = [:]
let scalars = "a".unicodeScalars
let aCode = scalars[scalars.startIndex].value


func getTime(_ start:String, _ end:String) -> Int {
    var start_b = start.components(separatedBy:":")
    var end_b = end.components(separatedBy:":")
    let hour = (Int(end_b[0])! - Int(start_b[0])!) * 60
    let min = Int(end_b[1])! + hour - Int(start_b[1])!
    return min
}

func convert(_ str:String) -> String {
    var str = str
    var candidate:String = ""
    for i in stride(from:0, to:str.count-1, by:1){
        var s_idx:String.Index = str.index(str.startIndex, offsetBy:i)
        var e_idx:String.Index = str.index(str.startIndex, offsetBy:i+1)

        if(str[e_idx] == "#"){
            var tmp = String(str[s_idx...e_idx])
            candidate += map[tmp]!
        }else if(str[s_idx] != "#"){
            candidate += map[String(str[s_idx])]!
        }

        if(i == str.count-2){
            candidate += map[String(str[e_idx])]!
        }
    }
    return candidate
}

func solution(_ m:String, _ musicinfos:[String]) -> String {
    var answer:String = "(None)"
    var len:Int = 0

    let letters: [String] = (0..<12).map {
        i in String(UnicodeScalar(aCode + i)!)
    }
    for e in elem{
        map[e] = letters[index]
        index += 1
    }
    var target = convert(m)
    for line in musicinfos {
        var block = line.components(separatedBy:",")
        var term = getTime(block[0], block[1])
        var candidate = convert(block[3])
        var quo = term / candidate.count
        var rem = term % candidate.count
        var finalStr:String = ""
        for i in stride(from:0, to:quo, by:1){
            finalStr += candidate
        }
        finalStr += candidate[..<candidate.index(candidate.startIndex, offsetBy:rem)]
        if(finalStr.contains(target)){
            if(finalStr.count > len){
                len = finalStr.count
                answer = block[2]
            }
        }
    }
    return answer
}

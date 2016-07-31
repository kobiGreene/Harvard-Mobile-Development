

import Foundation

class GridConfigurationParser {
    
    let configs : [AnyObject]
    
    init(configurations :[AnyObject]) {
        configs = configurations
    }
    
    func parse() -> [GridConfiguration]? {
        let dictConfigs = configs as! [NSDictionary]
        var parsedConfigs : [GridConfiguration] = []
        
        parsedConfigs = dictConfigs.map({(dict) -> GridConfiguration in
            let title = dict["title"] as! String
            let content = dict["contents"] as! [[Int]]
            let tupleContent = content.map({($0[0], $0[1])})
            
            return GridConfiguration(title: title, points: tupleContent)
        });
        return parsedConfigs
    }
}
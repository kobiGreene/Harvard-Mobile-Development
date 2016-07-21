//
//  MyProtocolWrapper.swift
//  section21
//
//  Created by Kobi Greene on 7/21/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

import Foundation

class MyProtocolWrapper {
    let myVariable : MyProtocol
    
    required init(variable: MyProtocol) {
        myVariable = variable
    }
}

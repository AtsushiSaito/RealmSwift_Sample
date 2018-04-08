//
//  DataClass.swift
//  Realm_Sample
//
//  Created by AtsushiSaito on 2018/04/08.
//  Copyright © 2018年 AtsushiSaito. All rights reserved.
//
import RealmSwift
import UIKit

class LabMember: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var old: Int32 = 0
}

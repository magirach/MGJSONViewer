//
//  MGFlatJSONParser.swift
//  Json Viewer
//
//  Created by Moinuddin Girach on 08/15/2022.
//  Copyright (c) 2022 Moinuddin Girach. All rights reserved.
//

import Foundation

final class MGFlatJSONParser {
    subscript(index: Int) -> MGFlatJSONElement {
        return values[index]
    }
    var count: Int {
        return values.count
    }
    
    func parse(fileName: String, ext: String) {
        if let path = Bundle.main.path(forResource: fileName,
                                       ofType: ext) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                parse(data: data)
            } catch {
                print(error)
            }
        }
    }
    
    func parse(data: Data) {
        do {
            let obj = try JSONSerialization.jsonObject(with: data)
            values = parse(data: obj,
                           level: 0)
        } catch {
            print(error)
        }
    }
    
    func expand(index: Int) -> Int {
        let obj = values[index]
        obj.isExpanded = true
        var values = parse(data: obj.child,
                           level: obj.level)
        values.removeFirst()
        self.values.insert(contentsOf: values,
                           at: index + 1)
        return values.count
    }
    
    func colapse(index: Int) -> Int {
        var count = 0
        let t = index + 1
        let obj = values[index]
        while values[t].level > obj.level {
            values.remove(at: t)
            count += 1
            if values.count <= t {
                break
            }
        }
        obj.isExpanded = false
        return count
    }
    
    private var values = [MGFlatJSONElement]()
    
    private func parse(data: Any?,
               level: Int) -> [MGFlatJSONElement] {
        var values = [MGFlatJSONElement]()
        processData(values: &values,
                    data: data,
                    level: level,
                    maxLevel: level)
        return values
    }
    
    private func processData(values: inout [MGFlatJSONElement],
                                    key: String? = nil,
                                    data: Any?,
                                    level: Int = 0,
                                    maxLevel: Int) {
        let val = MGFlatJSONElement()
        val.level = level
        val.key = key
        if key == nil {
            val.isExpanded = true
        }
        if let ob = data as? [String : Any] {
            val.value = "Object"
            val.type = .object
            val.child = ob
            val.numberOfChildren = ob.count
            values.append(val)
            if level <= maxLevel {
                for (key, value) in ob {
                    processData(values: &values,
                                key: key,
                                data: value,
                                level: level + 1,
                                maxLevel: maxLevel)
                }
            }
        } else if let ob = data as? [Any] {
            val.value = "Array[\(ob.count)]"
            val.type = .array
            val.child = ob
            val.numberOfChildren = ob.count
            values.append(val)
            if level <= maxLevel {
                for (index, v) in ob.enumerated() {
                    processData(values: &values,
                                key: "\(index)",
                                data: v,
                                level: level + 1,
                                maxLevel: maxLevel)
                }
            }
        } else if let d = data as? String {
            val.value = "\"\(d)\""
            val.type = .string
            values.append(val)
        } else if let d = data as? Bool {
            val.value = "\(d)"
            val.type = .bool
            values.append(val)
        } else {
            val.value = "\(data ?? "")"
            val.type = .number
            values.append(val)
        }
    }
}

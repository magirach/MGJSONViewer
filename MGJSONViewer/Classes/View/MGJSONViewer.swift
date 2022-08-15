//
//  MGJSONViewer.swift
//  Json Viewer
//
//  Created by Moinuddin Girach on 08/15/2022.
//  Copyright (c) 2022 Moinuddin Girach. All rights reserved.
//

import UIKit

public class MGJSONViewer: UIView {
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }
    
    public func loadData(data: Data) {
        values.parse(data: data)
        tblJSONViewer.reloadData()
    }
    
    public func loadData(fileName: String, ext: String) {
        values.parse(fileName: fileName, ext: ext)
        tblJSONViewer.reloadData()
    }
    
    private let tblJSONViewer: UITableView = {
        let tbl = UITableView(frame: .zero, style: .plain)
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.register(MGJSONViewerCell.self,
                     forCellReuseIdentifier: MGJSONViewerCell.reuseId)
        return tbl
    }()
    
    private var values = MGFlatJSONParser()
    
    private func setupView() {
        self.addSubview(tblJSONViewer)
        tblJSONViewer.delegate = self
        tblJSONViewer.dataSource = self
    }
    
    private func setupConstraints() {
        tblJSONViewer.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tblJSONViewer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tblJSONViewer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tblJSONViewer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}

extension MGJSONViewer: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        values.count
    }
    
    public func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MGJSONViewerCell.reuseId) as? MGJSONViewerCell {
            let val = values[indexPath.row]
            var space = ""
            for _ in 0..<val.level{
                space.append("   ")
            }
            cell.setData(data: val)
            return cell
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath) {
        let obj = values[indexPath.row]
        if let val = obj.value,
            obj.type == .string
            && val.contains("http") {
            if let url = URL(string: val) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
        } else {
            if obj.isExpanded {
                let rows = values.colapse(index: indexPath.row)
                var arr = [IndexPath]()
                for i in 0..<rows {
                    arr.append(IndexPath(row: indexPath.row + i + 1,
                                         section: 0))
                }
                tableView.deleteRows(at: arr,
                                     with: .none)
                tableView.reloadRows(at: [indexPath],
                                     with: .none)
            } else {
                let rows = values.expand(index: indexPath.row)
                var arr = [IndexPath]()
                for i in 0..<rows {
                    arr.append(IndexPath(row: indexPath.row + i + 1,
                                         section: 0))
                }
                tableView.insertRows(at: arr,
                                     with: .none)
                tableView.reloadRows(at: [indexPath],
                                     with: .none)
            }
        }
    }
}

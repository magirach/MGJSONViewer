//
//  MGJSONViewerCell.swift
//  Json Viewer
//
//  Created by Moinuddin Girach on 08/15/2022.
//  Copyright (c) 2022 Moinuddin Girach. All rights reserved.
//
import UIKit

class MGJSONViewerCell: UITableViewCell {
    
    static let reuseId = "MGJSONViewerCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }
    
    func setData(data: MGFlatJSONElement) {
        lbl.attributedText = prepareAtrributedString(obj: data)
        lblSpace.text = getSpacing(level: data.level)
        setState(isExpanded: data.isExpanded)
        setExpandalbleImage(type: data.type)
        self.layoutIfNeeded()
    }
    
    private let lblSpace: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        return lbl
    }()
    
    private let imgv: UIImageView = {
        let imgv = UIImageView()
        imgv.translatesAutoresizingMaskIntoConstraints = false
        imgv.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imgv.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return imgv
    }()
    
    private let lbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byCharWrapping
        return lbl
    }()
    
    private func setExpandalbleImage(type: MGFlatJSONElement.DataType) {
        switch type {
        case .array,  .object:
            imgv.alpha = 1
        default:
            imgv.alpha = 0
        }
    }
    
    private func setupView() {
        contentView.addSubview(lblSpace)
        contentView.addSubview(imgv)
        contentView.addSubview(lbl)
        let width = UIScreen.main.bounds.width
        separatorInset = UIEdgeInsets(top: 0, left: width, bottom: 0, right: 0)
        contentView.clipsToBounds = true
        selectionStyle = .none
    }
    
    private func setupConstraints() {
        lblSpace.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        lblSpace.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        
        imgv.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        imgv.leadingAnchor.constraint(equalTo: lblSpace.trailingAnchor, constant: 0).isActive = true
        
        lbl.leadingAnchor.constraint(equalTo: imgv.trailingAnchor, constant: 0).isActive = true
        lbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        lbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3).isActive = true
        lbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3).isActive = true
    }
    
    private func setState(isExpanded: Bool) {
        if isExpanded {
            imgv.image = UIImage(namedIn: "arrow_expanded")
        } else {
            imgv.image = UIImage(namedIn: "arrow_colapsed")
        }
    }
    
    private func getSpacing(level: Int) -> String {
        var space = ""
        for _ in 0..<level{
            space.append("\t")
        }
        return space
    }
    
    private func prepareAtrributedString(obj: MGFlatJSONElement) -> NSMutableAttributedString {
        
        let myString = "\(obj.key ?? "") : \(obj.value ?? "")"
        let myAttrString = NSMutableAttributedString(string: myString)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3
        myAttrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myString.count))
        
        myAttrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.purple, range: NSRange(location: 0, length: obj.key?.count ?? 0))
        if obj.type == .string {
            if let val = obj.value, val.contains("http") {
                myAttrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.link, range: NSRange(location: (obj.key?.count ?? 0) + 3, length: obj.value?.count ?? 0))
                myAttrString.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor.link, range: NSRange(location: (obj.key?.count ?? 0) + 3, length: obj.value?.count ?? 0))
                myAttrString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSRange(location: (obj.key?.count ?? 0) + 3, length: obj.value?.count ?? 0))
            } else {
                myAttrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: (obj.key?.count ?? 0) + 3, length: obj.value?.count ?? 0))
            }
        } else if obj.type == .number || obj.type == .bool {
            myAttrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.link, range: NSRange(location: (obj.key?.count ?? 0) + 3, length: obj.value?.count ?? 0))
        }
        return myAttrString
    }
}


extension UIImage {
    convenience init?(namedIn: String) {
        let bundle = Bundle(for: MGJSONViewerCell.self)
        self.init(named: namedIn, in: bundle, with: nil)
    }
}

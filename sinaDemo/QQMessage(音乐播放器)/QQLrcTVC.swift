//
//  QQLrcTVC.swift
//  sinaDemo
//
//  Created by admin on 2017/5/16.
//  Copyright © 2017年 super. All rights reserved.
//

import UIKit

class QQLrcTVC: UITableViewController {

    // 滚动到哪一行
    var scrollRow = -1 {
        didSet{
            if scrollRow == oldValue {
                return
            }
            tableView.reloadRows(at: tableView.indexPathsForVisibleRows!, with: UITableViewRowAnimation.fade)
            
            tableView.scrollToRow(at: IndexPath(row: scrollRow,section:0), at: UITableViewScrollPosition.middle, animated: true)
        }
    }
    
    // 进度
    var progress: CGFloat = 0 {
        didSet{
         let cell = tableView.cellForRow(at: IndexPath(row: scrollRow, section: 0)) as? QQLrcCell
          cell?.progress = progress
        }
    }
    
    // 歌词模型
    var lrcMs: [QQLrcModel] = [QQLrcModel](){
        didSet{
          tableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.contentInset = UIEdgeInsetsMake(tableView.height * 0.5, 0, tableView.height * 0.5, 0)
        
    }
    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return lrcMs.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = QQLrcCell.init(style: .default, reuseIdentifier: "QQLrcCellID")
        if indexPath.row == scrollRow {
            cell.progress = progress
        }else {
            cell.progress = 0
        }
        
        cell.lrcContent = lrcMs[indexPath.row].lrcContent

        return cell
    }
   
}

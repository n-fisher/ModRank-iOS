//
//  StatsViewController.swift
//  ModRank
//
//  Created by Nick Fisher on 12/5/17.
//  Copyright © 2017 Nick Fisher. All rights reserved.
//

import Foundation
import UIKit
import Charts

class StatsViewController: UIViewController, UINavigationControllerDelegate, IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        for mod in mods {
            if Double(mod.subs) == value {
                return mod.itemTitle
            }
        }
        return ""
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        for mod in mods {
            if Double(mod.subs) == value {
                return mod.itemTitle
            }
        }
        return ""
    }
    
    //MARK: Properties
    var mods = [ModInfo]()
    @IBOutlet weak var pie: PieChartView!
    @IBOutlet weak var bar: BarChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        renderCharts()
    }
    
    func updatePie() {
        var dataSet = [PieChartDataEntry]()
        for mod in mods {
            dataSet.append(
                PieChartDataEntry(value: Double(mod.views), label: mod.itemTitle)
            )
        }
        let dataSets = PieChartDataSet(values: dataSet, label: "Views")
        dataSets.colors = ChartColorTemplates.joyful()
        dataSets.valueTextColor = .black
        pie.data = PieChartData(dataSet: dataSets)
        pie.chartDescription?.text = "Views"
        
        //This must stay at end of function
        pie.notifyDataSetChanged()
    }
    
    func updateRadar() {
        var dataSet = [BarChartDataEntry]()
        for mod in 0..<mods.count {
            dataSet.append(
                BarChartDataEntry(x: Double(mod), y: Double(mods[mod].subs))
            )
        }
        let data = BarChartDataSet(values: dataSet, label: "Downloads")
        bar.chartDescription?.text = "Downloads"
        data.valueFormatter = self
        bar.data = BarChartData(dataSet: data)


        //This must stay at end of function
        bar.notifyDataSetChanged()
    }
    
    func renderCharts() {
        updateRadar()
        updatePie()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The ViewController is not inside a navigation controller.")
        }
    }
}

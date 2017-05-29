//
//  ViewController.swift
//  Charts Examples
//
//  Created by Anna Hazard on 5/28/17.
//  Copyright © 2017 Anna Hazard. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    @IBOutlet weak var number1: UISlider!
    @IBOutlet weak var number2: UISlider!
    @IBOutlet weak var number3: UISlider!
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var barChart: BarChartView!
    
    @IBAction func renderCharts() {
        barChartUpdate()
        pieChartUpdate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        barChartUpdate()
        pieChartUpdate()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func barChartUpdate () {
        
        // Basic set up of plan chart
        
        let entry1 = BarChartDataEntry(x: 1.0, y: Double(number1.value))
        let entry2 = BarChartDataEntry(x: 2.0, y: Double(number2.value))
        let entry3 = BarChartDataEntry(x: 3.0, y: Double(number3.value))
        let dataSet = BarChartDataSet(values: [entry1, entry2, entry3], label: "Widgets Type")
        let data = BarChartData(dataSets: [dataSet])
        barChart.data = data
        barChart.chartDescription?.text = "Number of Widgets by Type"

        // Color
        dataSet.colors = ChartColorTemplates.vordiplom()

        // Refresh chart with new data
        barChart.notifyDataSetChanged()
    }
    
    func pieChartUpdate () {
        
        // Basic set up of plan chart
        
        let entry1 = PieChartDataEntry(value: Double(number1.value), label: "#1")
        let entry2 = PieChartDataEntry(value: Double(number2.value), label: "#2")
        let entry3 = PieChartDataEntry(value: Double(number3.value), label: "#3")
        let dataSet = PieChartDataSet(values: [entry1, entry2, entry3], label: "Widget Types")
        let data = PieChartData(dataSet: dataSet)
        pieChart.data = data
        pieChart.chartDescription?.text = "Share of Widgets by Type"

        // Color
        dataSet.colors = ChartColorTemplates.joyful()
        //dataSet.valueColors = [UIColor.black]
        pieChart.backgroundColor = UIColor.black
        pieChart.holeColor = UIColor.clear
        pieChart.chartDescription?.textColor = UIColor.white
        pieChart.legend.textColor = UIColor.white
        
        // Text
        pieChart.legend.font = UIFont(name: "Futura", size: 10)!
        pieChart.chartDescription?.font = UIFont(name: "Futura", size: 12)!
        pieChart.chartDescription?.xOffset = pieChart.frame.width
        pieChart.chartDescription?.yOffset = pieChart.frame.height * (2/3)
        pieChart.chartDescription?.textAlign = NSTextAlignment.left

        // Refresh chart with new data
        pieChart.notifyDataSetChanged()
    }


}


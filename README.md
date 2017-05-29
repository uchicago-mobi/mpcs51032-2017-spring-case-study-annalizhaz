Charts for Swift Basic Setup
============================

Anna Hazard

 

This is guide to getting started using [Daniel Gindi’s
Charts](https://github.com/danielgindi/Charts) library in Swift. Charts is
charting framework for iOS based off of a popular charting library for Android,
[MPAndroidChart](https://github.com/PhilJay/MPAndroidChart).

There is a demo project in the Charts repository which is far more complete than
this project. However, as the demo project is written in Objective-C and the
only complete documentation that exists for the library is for the Android
version, I thought it would be useful to create a tutorial and example project
for those who want to see the basic set up in Swift. Additionally, there is a
small issue when installing the framework using Cocoa Pods that took me some
time sorting through closed issues to figure out, so hopefully I can make the
process of setting up more seamless for others.

 

This tutorial will lead to the completion of the very basic example project in
this repository, but if you aren’t following along creating this starter project
the steps should be generalizable to your own project.

 

I created this example project using the following versions:

-   Swift 3.1

-   Xcode 8.3.2

-   Charts 3.0.2

 

Starting a Project in Xcode using with Charts and Cocoa Pods
------------------------------------------------------------

Open Xcode and start a new project as usual. Then, close Xcode and navigate
inside the project folder from the terminal (you should be at the same level as
your Xcode project file). Then, type `pod init` and hit enter. You should now
see a document named “Podfile” in the project folder. Open this file with a text
editor, and add `pod ‘Charts’` above the word `end`.

 

Your Podfile should now look something like this:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Uncomment the next line to define a global platform for your project
    platform :ios, '9.0'

target 'Your Project Name' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Charts Examples

  pod 'Charts'

end
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

You can also add any other pods you need for your project to this file at this
time (one pod per line, anywhere between `use_frameworks!` and `end`). Save and
close the Podfile and return to the terminal. Now type `pod install` and hit
enter. You should now have another file in the project called
“YourProjectName.xcworkspace.” You will be working with this file rather than
the project file.

**Open the work space file, and run the application.**

If you skip this step, whenever you try to import and use the Charts library in
a ViewController, Xcode will give you an error.

 

Preparing the Storyboard
------------------------

All of the charts in the Charts library are subclasses of UIView, so add a
UIView to the storyboard wherever you would like to have a chart. Then, change
the “Class” of the UIView to the appropriate chart type. Charts currently
offered:

-   LineChart

-   BarChart

-   Horizontal-BarChart

-   PieChart

-   ScatterChart

-   CandleStickChart

-   BubbleChart

-   RadarChart

 

For the example project, I am using a bar chart and a pie chart, and adding
three sliders to generate data for the charts. The set up should look something
like this:

 

![](https://github.com/annalizhaz/ChartsForSwiftBasic/blob/master/Tutorial%20Images/setup.png)

 

I gave the top view the class PieChartView and the bottom view the class
BarChartView. I also set the maximum value of each slider to 100 and the default
value to 50.

 

Setting up the ViewController
-----------------------------

At the top of the ViewController.swift file, underneath `import UIKit`, type
`import Charts`. If you get the error “Cannot load underlying module for
‘Charts’,” see the first section of this tutorial. This can most likely be
remedied by commenting out your `import Charts` statement, running the
application in the simulator, and uncommenting `import Charts`.

 

Add the following properties to the top of your ViewController class:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@IBOutlet weak var number1: UISlider!
@IBOutlet weak var number2: UISlider!
@IBOutlet weak var number3: UISlider!
@IBOutlet weak var pieChart: PieChartView!
@IBOutlet weak var barChart: BarChartView!
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

Then create two functions, one to update the appearance of the bar chart and one
to update the appearance of the pie chart. These will also be added to the
ViewController class:

 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
func barChartUpdate () {
    //future home of bar chart code
}
func pieChartUpdate () {
    //future home of pie chart code 
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

Now underneath the properties you added earlier add the action that will be
called overtime the slider values change:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@IBAction func renderCharts() {
        barChartUpdate()
        pieChartUpdate()
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Also add `barChartUpdate()` and `pieChartUpdate()` to the `viewDidLoad()`
function so it looks like this:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
override func viewDidLoad() {
        super.viewDidLoad()
        barChartUpdate()
        pieChartUpdate()
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

Finally, return to the storyboard and connect the storyboard elements to their
respective properties in the ViewController. Each slider should be connected to
a different `number_` property while the pie chart and bar chart views should be
connected to their respective properties. Lastly, connected the “Value Changed”
event for each slider to the `renderCharts()` action.

 

How “Charts" Processes Data
---------------------------

There are three levels between your data point and the chart object as it is
rendered an your screen. Each data point is an entity object, many of which are
contained in a data set object, many of which are contained in a data object.
Each chart has one data object. Each chart type has its own hierarchy of data
objects (i.e., there is a `PieChartDataEntity` class in addition a
`BarChartDataEntity` class and so on), but they all follow this pattern.

 

For this tutorial we will just be using three data points which we will consider
part of one data set, but multiple data sets can be used to set up multi-series
charts.

 

Basic Chart Set-up
------------------

Back in the ViewController.swift file, add the following to the
`barChartUpdate()` function:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let entry1 = BarChartDataEntry(x: 1.0, y: Double(number1.value))
let entry2 = BarChartDataEntry(x: 2.0, y: Double(number2.value))
let entry3 = BarChartDataEntry(x: 3.0, y: Double(number3.value))
let dataSet = BarChartDataSet(values: [entry1, entry2, entry3], label: "Widgets Type")
let data = BarChartData(dataSets: [dataSet])
barChart.data = data
barChart.chartDescription?.text = "Number of Widgets by Type"

//All other additions to this function will go here

//This must stay at end of function
barChart.notifyDataSetChanged()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

And the following to the `pieChartUpdate()`function:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let entry1 = PieChartDataEntry(value: Double(number1.value), label: "#1")
let entry2 = PieChartDataEntry(value: Double(number2.value), label: "#2")
let entry3 = PieChartDataEntry(value: Double(number3.value), label: "#3")
let dataSet = PieChartDataSet(values: [entry1, entry2, entry3], label: "Widget Types")
let data = PieChartData(dataSet: dataSet)
pieChart.data = data
pieChart.chartDescription?.text = "Share of Widgets by Type"

//All other additions to this function will go here

//This must stay at end of function
pieChart.notifyDataSetChanged()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This will set up two basic charts with the default settings from the library.
Run the application to see the basic charts and you should get something like
this:

 

![](https://github.com/annalizhaz/ChartsForSwiftBasic/blob/master/Tutorial%20Images/initial.png)

 

Moving any of the sliders should change the value of the charts. The final
statement in these functions should remain last as we make other additions; this
signals to the chart object to recalculate its features on the basis of the new
data.

 

Customize Appearance
--------------------

I will cover a few of the built-in ways to customize the appearance of charts,
but there are many more beyond this. You can further customize charts by digging
into the classes in the framework itself if the customization you want is not
available, but I won’t be covering that for the moment.

 

### Color

First I’ll be adding custom colors using built in color themes. You can see that
the pie chart (it’s a really a donut chart I suppose) especially needs some
color in order to tell the segments apart.

 

Add the following to the `pieChartUpdate()`function after your other code:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dataSet.colors = ChartColorTemplates.joyful()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

If you run the application, you’ll see this changes the pie chart to three
bright colors, but also changes the text on the chart to white. Since the white
labels partially disappear on the white background, let’s change the label text
to black by adding this to the same function:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dataSet.valueColors = [UIColor.black]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

Alternatively, we could change the background to black. We would then also need
to change all the other text to a lighter color so it doesn’t disappear on the
black background. In order to accomplish this, add the following code to the
same function (and comment out the `dataSet.valueColors = [UIColor.black]`
line):

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
pieChart.backgroundColor = UIColor.black
pieChart.holeColor = UIColor.clear
pieChart.chartDescription?.textColor = UIColor.white
pieChart.legend.textColor = UIColor.white
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

The pie “hole” is by default white. By setting it to clear, we can insure that
it will take on whatever color we set as the background color.

 

Let’s also color the bar chart. Add the following to the `barChartUpdate()`
function:

 

 

### Text

In addition to color, it is possible to change the font and size of the text on
the chart in addition to the position of the title. We can further polish up the
pie chart by adding this code:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
pieChart.legend.font = UIFont(name: "Futura", size: 10)!
pieChart.chartDescription?.font = UIFont(name: "Futura", size: 12)!
pieChart.chartDescription?.xOffset = pieChart.frame.width + 30
pieChart.chartDescription?.yOffset = pieChart.frame.height * (2/3)
pieChart.chartDescription?.textAlign = NSTextAlignment.left
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

Here I am changing the legend and title fonts and moving the chart title from
the bottom-right to the top-left. Note that the default offset for this item is
(0, 0), which is in the bottom right corner of the view (as opposed the more
typical top-left origin)

 

Finally you should see this when you build and run:

 

![](https://github.com/annalizhaz/ChartsForSwiftBasic/blob/master/Tutorial%20Images/final.png)

 

Next Steps
----------

Now that you can set up a basic project using Charts in Swift, it should be
easier to carry out further customization using the MPAndroidCharts docs as a
reference for what is possible. Charts is synchronized with MPAndroidCharts so
that customizing a feature in MPAndroidCharts should be very similar to doing so
in Charts, and what is possible in one should also be possible in the other.



import UIKit

@IBDesignable

class GridView: UIView {
    var mainRows = 10
    var mainCols = 10
    @IBInspectable var rows: Int = 0 {
        didSet{
            //resetgrid
            mainRows = rows
            setNeedsDisplay()
        }
    }
    @IBInspectable var cols: Int = 0{
        didSet{
            mainCols = cols
            setNeedsDisplay()
        }
        
    }

    @IBInspectable var livingColor: UIColor = UIColor.greenColor()
    @IBInspectable var emptyColor: UIColor = UIColor.grayColor()
    @IBInspectable var bornColor: UIColor = UIColor.blueColor()
    @IBInspectable var diedColor: UIColor = UIColor.redColor()
    @IBInspectable var gridColor: UIColor = UIColor.blackColor()
    @IBInspectable var gridWidth: CGFloat = 30.0
    
    var points: Array<(Int,Int)> {
        get {
            var array = [(Int,Int)]()
            
            for y in 0..<mainRows {
                for x in 0..<mainCols {
                    if ConfigurationEditorViewController().isLiving(y,x: x) {
                        array.append((y,x))
                    }
                }
            }
            return array
        }
        set {
            for point in newValue {
                for y in 0..<mainRows {
                    for x in 0..<mainCols {
                        if y == point.0 && x == point.1{
                            ConfigurationEditorViewController().switchToAlive(y, x: x)
                        }
                }
            }
            }

        }
    }
    
    var width: CGFloat!
    var height: CGFloat!
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if rect.size.width <= self.frame.width / 2 {
            let gridPath = UIBezierPath()
            gridPath.lineWidth = gridWidth
            gridPath.moveToPoint(CGPoint(x: rect.origin.x, y: rect.origin.y))
            gridPath.addLineToPoint(CGPoint(x: rect.origin.x + width, y: rect.origin.y + height ))
            gridPath.moveToPoint(CGPoint(x: rect.origin.x, y: rect.origin.y + height))
            gridPath.addLineToPoint(CGPoint(x: rect.origin.x + width, y: rect.origin.y + height ))
            gridColor.setStroke()
            gridPath.stroke()
            gridPath.moveToPoint(CGPoint(x: rect.origin.x, y: rect.origin.y))
            gridPath.addLineToPoint(CGPoint(x: rect.origin.x , y: rect.origin.y + height))
            gridPath.moveToPoint(CGPoint(x: rect.origin.x + width, y: rect.origin.y))
            gridPath.addLineToPoint(CGPoint(x: rect.origin.x + width , y: rect.origin.y + height))
            gridColor.setStroke()
            gridPath.stroke()
            
            let newRow = Int(ceil(rect.origin.y / height))
            let newCol = Int(ceil(rect.origin.x / width))
            let center = findCenter(newRow, col: newCol, theWidth: width, theHeight: height)
            let radius = (width / 2) - (width / 8)
            let arcWidth: CGFloat = 0.1
            let startAngle: CGFloat = 0
            let endAngle: CGFloat = 2 * CGFloat(M_PI)
            let oval = UIBezierPath(arcCenter: center,
                                    radius: radius,
                                    startAngle: startAngle,
                                    endAngle: endAngle,
                                    clockwise: true)
            //Changing color for circle based on status
            oval.lineWidth = arcWidth
            switch ConfigurationEditorViewController().gridStates(newRow, x: newCol){
            case .Alive:
                livingColor.setFill()
                livingColor.setStroke()
            case .Empty:
                emptyColor.setFill()
                emptyColor.setStroke()
            case .Born:
                bornColor.setFill()
                bornColor.setStroke()
            case .Died:
                diedColor.setFill()
                diedColor.setStroke()
            }
            oval.fill()
            oval.stroke()
        }else {
            
            let gridPath = UIBezierPath()
            gridPath.lineWidth = gridWidth
            width = rect.width / CGFloat(mainCols - 1)
            height = rect.height / CGFloat(mainRows - 1)
            //Drawing the grid
            for i in 0..<mainRows{
                gridPath.moveToPoint(CGPoint(x: bounds.origin.x, y: bounds.origin.y + height * CGFloat(i)))
                gridPath.addLineToPoint(CGPoint(x: bounds.origin.x + width * CGFloat(cols) , y: bounds.origin.y + height * CGFloat(i)))
                gridColor.setStroke()
                gridPath.stroke()
            }
            for i in 0..<mainCols {
                gridPath.moveToPoint(CGPoint(x: bounds.origin.x + width * CGFloat(i), y: bounds.origin.y))
                gridPath.addLineToPoint(CGPoint(x: bounds.origin.x + width * CGFloat(i) , y: bounds.origin.y + height * CGFloat(cols)))
                gridColor.setStroke()
                gridPath.stroke()
            }
            for y in 0..<mainRows{
                for x in 0..<mainCols {
                    //Draws circle
                    let center = findCenter(y, col: x, theWidth: width, theHeight: height)
                    let radius = (width / 2) - (width / 8)
                    let arcWidth: CGFloat = 0.1
                    let startAngle: CGFloat = 0
                    let endAngle: CGFloat = 2 * CGFloat(M_PI)
                    let oval = UIBezierPath(arcCenter: center,
                                            radius: radius,
                                            startAngle: startAngle,
                                            endAngle: endAngle,
                                            clockwise: true)
                
                    oval.lineWidth = arcWidth
                
                    //Changing color for circle based on status
                    switch ConfigurationEditorViewController().gridStates(y, x: x){
                    case .Alive:
                        livingColor.setFill()
                        livingColor.setStroke()
                    case .Empty:
                        emptyColor.setFill()
                        emptyColor.setStroke()
                    case .Born:
                        bornColor.setFill()
                        bornColor.setStroke()
                    case .Died:
                        diedColor.setFill()
                        diedColor.setStroke()
                    }
                    oval.fill()
                    oval.stroke()
                }
            }
        
        }
    }
    //finding the center of each cell to draw the circele
    func findCenter(row: Int, col: Int, theWidth: CGFloat, theHeight: CGFloat) -> CGPoint{
        let x1 = CGFloat(col) * theWidth
        let y1 = CGFloat(row) * theHeight
        let x2 = x1 + theWidth
        let y2 = y1 + theHeight
        return CGPoint(x: (x1 + x2) / 2, y: (y1 + y2) / 2)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var rect = CGRect(x:0, y: 0, width: width, height: height)
        for touch in touches {
            for y in 0..<mainRows {
                for x in 0..<mainCols {
                    // creates rect that moves to check which cell was touched
                    rect.origin = CGPoint(x: 0.0 + width * CGFloat(x), y: 0 + height * CGFloat(y))
                    if CGRectContainsPoint(rect, touch.locationInView(self)){
                        if ConfigurationEditorViewController().isLiving(y,x: x) {
                            ConfigurationEditorViewController().switchToEmpty(y, x: x)
                        }else {
                            ConfigurationEditorViewController().switchToAlive(y, x: x)
                        }
                        
                        setNeedsDisplayInRect(rect)
                    }
                }
            }
        }
    }
    


}














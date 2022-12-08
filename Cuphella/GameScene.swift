//
//  GameScene.swift
//  Cuphella
//
//  Created by Kiar on 06/12/22.
//minuto 52 https://www.youtube.com/watch?v=fGJCb_oweG0

import SpriteKit

class GameScene: SKScene
{
    var playerVirus: SKSpriteNode!
    var points: [CGPoint] = []
    var touched: Bool = false
    //var enemy1: Enemy!
    //var enemy2: Enemy!
    var totalScore = 0
    var showedScore = UILabel()
    var sceneCamera: SKCameraNode = SKCameraNode()
    var swipeStart: CGPoint = CGPoint.zero
    var swipeEnd: CGPoint = CGPoint.zero
    var scoreLabel: SKLabelNode =
    {
        var label = SKLabelNode()
        label.fontSize = CGFloat(15)
        label.color = .red
        label.text = "00"
        label.verticalAlignmentMode = .bottom
        label.horizontalAlignmentMode = .center
        label.zPosition = 3
        return label
    }()
    
    struct Light
    {
        var lightCell: [[Int]] = [[]]
        var turnedOn: Bool = false
    }
    
    var countDownTimerLabel: SKLabelNode =
    {
        var label = SKLabelNode(fontNamed: "")
        label.fontSize = CGFloat(15)
        label.zPosition = 2
        label.color = .red
        label.horizontalAlignmentMode = .left
        label.verticalAlignmentMode = .center
        //label.text
        return label
    }()
    
    
    var touchUP = SKSpriteNode(color: UIColor.white, size: CGSize(width: 100,
                                                                   height:100))
    var touchDown = SKSpriteNode(color: UIColor.white, size: CGSize(width: 100,
                                                                   height:100))
    var touchLeft = SKSpriteNode(color: UIColor.white, size: CGSize(width: 100,
                                                                   height:100))
    var touchRight = SKSpriteNode(color: UIColor.white, size: CGSize(width: 100,
                                                                   height:100))
    
    var arrayPoint: [[Int]] = [[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
                               [1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1],
                               [1,0,1,1,1,1,0,1,1,0,1,0,1,1,0,1,1,1,1,0,1],
                               [1,0,1,1,1,1,0,1,1,0,1,0,1,1,0,1,1,1,1,0,1],
                               [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
                               [1,0,1,1,1,0,1,0,1,1,1,1,1,0,1,0,1,1,1,0,1],
                               [1,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0,0,1],
                               [1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1],
                               [1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,0,1,1,1,1,1],
                               [1,1,1,1,1,0,0,0,0,1,0,1,1,0,1,0,1,1,1,1,1],
                               [1,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,1],
                               [1,1,1,1,1,0,1,0,1,0,0,0,1,0,1,0,1,1,1,1,1],
                               [1,1,1,1,1,0,1,0,1,1,1,1,1,0,1,0,1,1,1,1,1],
                               [1,1,1,1,1,0,1,0,0,0,0,0,0,0,1,0,1,1,1,1,1],
                               [1,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,1],
                               [1,0,1,1,1,0,1,1,1,0,1,0,1,1,1,0,1,1,1,0,1],
                               [1,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,1],
                               [1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1],
                               [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
                               [1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1],
                               [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
                               [1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,0,1],
                               [1,0,1,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,1,0,1],
                               [1,0,1,0,0,0,0,1,0,1,0,1,0,1,0,0,0,0,1,0,1],
                               [1,0,1,1,1,1,1,1,0,1,0,1,0,1,1,1,1,1,1,0,1],
                               [1,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,1],
                               [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]]
    
    
    //DidMoveTo
    override func didMove(to view: SKView)
    {
        CreateMap()
        CreatePlayer()
        CreateInput()
        //scoreLabel.position = CGPoint(x: frame.width, y: frame.width)
        addChild(scoreLabel)
        //CreateEnemy1()
        countDownTimerLabel.position = CGPoint(x: frame.width * 2, y: frame.height * 2)
        addChild(countDownTimerLabel)
        camera = sceneCamera
        camera?.xScale = 0.5
        camera?.yScale = 0.5
        
    }
}

//MARK: Map
extension GameScene
{
    func CreateMap()
    {
        var x: CGFloat = -self.size.width/2 + self.size.width/CGFloat(arrayPoint[0].count)
        //var y: CGFloat = self.size.width/2 - self.size.width/CGFloat(arrayPoint[0].count)/2
        var y: CGFloat = self.size.width - self.size.width/CGFloat(arrayPoint[0].count)
        
        for i in 0...arrayPoint.count-1
        {
            x = -self.size.width/2 + self.size.width/CGFloat(arrayPoint[0].count) //-10
            
            if(i == 0)
            {
                //y =  self.size.width/2 - self.size.width/CGFloat(arrayPoint[0].count)/2
                y =  self.size.width - self.size.width/CGFloat(arrayPoint[0].count) - 50
            }
            else
            {
                y -= self.size.width/CGFloat(arrayPoint[0].count)
            }
            
            for j in 0...arrayPoint[0].count-1
            {
                let ground = SKSpriteNode()
                ground.size = CGSize(width: self.size.width/CGFloat(arrayPoint[0].count),
                                     height: self.size.width/CGFloat(arrayPoint[0].count))
                
                if(arrayPoint[i][j] == 0)
                {
                    let redBloodCell = SKSpriteNode(color: UIColor.red, size: CGSize(width: 3, height: 3))
                    redBloodCell.name = "redBloodCell"
                    ground.name = "0"
                    ground.color = .black
                    ground.addChild(redBloodCell)
                }
                else if(arrayPoint[i][j] == 1)
                {
                    ground.name = "1"
                    ground.texture = SKTexture(imageNamed: "brickPixel")
                }
                
                ground.position = CGPoint(x: x, y: y)
                x += self.size.width/CGFloat(arrayPoint[0].count)
                                             
                addChild(ground)
                points.append(ground.position)
            }
        }
    }
}

//MARK: Player
extension GameScene
{
    func CreatePlayer()
    {
        playerVirus = SKSpriteNode(color: UIColor.green, size: CGSize(width: self.size.width/CGFloat(arrayPoint[0].count),
                                                                      height: self.size.width/CGFloat(arrayPoint[0].count)))
        playerVirus.name = "Player"
        playerVirus.position = points[481]
        addChild(playerVirus)
    }
    
    func MovePlayer(x: CGFloat, y: CGFloat)
    {
        if(touched)
        {
            let next = nodes(at: CGPoint(x: playerVirus.position.x + x, y: playerVirus.position.y + y)).last
        
            if(next?.name == "0")
            {
                if(next?.childNode(withName: "redBloodCell") != nil)
                {
                    next?.childNode(withName: "redBloodCell")?.removeFromParent()
                    totalScore += 1
                    UpdateScore()
                    print(totalScore)
                }
                playerVirus.position = next!.position
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100))
                {
                    [self] in
                    MovePlayer(x: x, y: y)
                }
            }
        }

}
    
    func UpdateScore()
    {
        scoreLabel.text = "\(totalScore)"
    }
}

//MARK: Inupt
extension GameScene
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first!
        let location = touch.location(in: self)
        
        if(atPoint(location).name == "left")
        {
            touched = true
            childNode(withName: "left")?.alpha = 1
            MovePlayer(x: -self.size.width/CGFloat(arrayPoint[0].count), y: 0)
            print("left")
        }
        else if(atPoint(location).name == "up")
        {
            touched = true
            childNode(withName: "up")?.alpha = 1
            MovePlayer(x: 0, y: self.size.width/CGFloat(arrayPoint[0].count))
            print("up")
        }
        else if(atPoint(location).name == "down")
        {
            touched = true
            childNode(withName: "down")?.alpha = 1
            MovePlayer(x: 0, y: -self.size.width/CGFloat(arrayPoint[0].count))
            print("down")
        }
        else if(atPoint(location).name == "right")
        {
            touched = true
            childNode(withName: "right")?.alpha = 1
            MovePlayer(x: self.size.width/CGFloat(arrayPoint[0].count), y: 0)
            print("right")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for child in children
        {
            if(child.name == "left" || child.name == "up" || child.name == "down" || child.name == "right")
            {
                child.alpha = 0.5
            }
        }
        touched = false
    }
    
    func touchDown(atPoint pos: CGPoint)
    {
        swipeStart = pos
        printContent("Ciao")
    }
}

extension GameScene
{
    class GameManager: SKScene
    {
        var counterT = 0
        var countTime = Timer()
        var counterStartValue = 60
    }
}


//MARK: GameManager
extension GameScene
{
    override func update(_ currentTime: TimeInterval)
    {
        camera?.position.x = playerVirus.position.x
        camera?.position.y = playerVirus.position.y
       
        touchUP.position.x = (camera?.position.x)! - (playerVirus.size.height * 2)
        touchUP.position.y = (camera?.position.y)! - (playerVirus.size.height * 2)
        
        touchLeft.position.x = (camera?.position.x)! - (playerVirus.size.height * 3)
        touchLeft.position.y = (camera?.position.y)! - (playerVirus.size.height * 3)
        
        touchRight.position.x = (camera?.position.x)! //+ (playerVirus.size.height)
        touchRight.position.y = (camera?.position.y)! - (playerVirus.size.height * 3)
        
        touchDown.position.x =  (camera?.position.x)! - (playerVirus.size.height * 2)
        touchDown.position.y = (camera?.position.y)! - (playerVirus.size.height * 4)
    }
}


extension GameScene
{
    func CreateInput()
    {
        touchUP.name = "up"
        touchUP.size = playerVirus.size
        touchUP.zPosition = 2
        addChild(touchUP)
        
        touchDown.name = "down"
        touchDown.size = playerVirus.size
        touchDown.zPosition = 2
        addChild(touchDown)

        touchLeft.name = "left"
        touchLeft.size = playerVirus.size
        touchLeft.zPosition = 2
        addChild(touchLeft)

        touchRight.name = "right"
        touchRight.size = playerVirus.size
        touchRight.zPosition = 2
        addChild(touchRight)

    }
}

//MARK: Enemy
/*extension GameScene
{
    class Enemy
    {
        var whiteBloodCell: SKSpriteNode!
        var scene: SKScene!
        var directions: [String] = []
        var directionTrue: [String] = []
        var startMove: String!

        init(whiteBloodCell: SKSpriteNode, scene: SKScene)
        {
            self.whiteBloodCell = whiteBloodCell
            self.scene = scene
        }
        
        func CreateEnemy()
        {
            scene.addChild(whiteBloodCell)
        }
        
        func Check(i: Int) -> String
        {
            switch i
            {
                case 0:
                    return "left"
            case 1:
                return "right"
            case 2:
                return "up"
            default:
                return "down"
            }
        }
        
        func NodeNext(x: CGFloat, y: CGFloat) -> SKNode
        {
            return scene.nodes(at: CGPoint(x: whiteBloodCell.position.x + x, y: whiteBloodCell.position.y + y)).last!
        }
        
        func ReturnNode(name: String) ->SKNode
        {
            switch name
            {
                case "left":
                    return NodeNext(x: -scene.size.width/21, y: 0)
            case "rigt":
                return NodeNext(x: scene.size.width/21, y: 0)
            case "up":
                return NodeNext(x:0, y: scene.size.width/21)
            case "down":
                return NodeNext(x: 0, y: -scene.size.width/21)
            default:
                return SKNode()
            }
        }
        
        func CheckDirection()
        {
            directions.removeAll()
            directionTrue.removeAll()
            
            let left = NodeNext(x: -scene.size.width/21, y: 0).name
            let right = NodeNext(x: scene.size.width/21, y: 0).name
            let up = NodeNext(x: 0, y: scene.size.width/21).name
            let down = NodeNext(x: 0, y: -scene.size.width/21).name
            
            directions.append(left!)
            directions.append(right!)
            directions.append(up!)
            directions.append(down!)
            
            for i in 0...directions.count - 1
            {
                if(directions[i] == "0" && directionTrue.count < 3)
                {
                    directionTrue.append(Check(i: i))
                }
            }
        }
        
        func MoveEnemy()
        {
            let next = ReturnNode(name: startMove)
            CheckDirection()
           
            if(next.name == "0")
            {
                whiteBloodCell.position = next.position

                //CreateActionGhost(to: next)
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100))
                {[self] in
                    MoveEnemy()
                }
            }
            else
            {
                //CheckDirection()
                startMove = directionTrue.randomElement()
                //CreateActionGhost(to: ReturnNode(name: startMove))
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100))
                {[self] in
                    whiteBloodCell.position = ReturnNode(name: startMove).position
                    MoveEnemy()
                }
            }
        }
        
    //    func CreateActionGhost(to: SKNode)
    //    {
    //        let move = SKAction.move(to: to.position, duration: 0.2)
    //        let void = SKAction.run{[self] in
    //            MoveEnemy()
    //        }
    //        let sequence = SKAction.sequence([move, void])
    //        .run(sequence)
    //    }
    }
}
*/

//MARK: EnemiesList
/*
extension GameScene
{
    func CreateEnemy1()
    {
        
        let enemy = SKSpriteNode(color: .white, size: CGSize(width: self.size.width/21,
                                                             height: self.size.width/21))
        enemy1 = enemy(whiteBloodCell: enemy, scene: self)
        enemy1.CreateEnemy()
        enemy1.CheckDirection()
        enemy1.startMove = enemy1.directionTrue.randomElement()
        
//        for i in 0...enemy1.directionTrue.count - 1
//        {
//            printContent(enemy1.directionTrue[i])
//        }
        enemy1.MoveEnemy()
    }
//    
//    func CreateEnemy2()
//    {
//        let enemy = SKSpriteNode(color: .white, size: CGSize(width: self.size.width/21,
//                                                             height: self.size.width/21))
//        enemy2 = Enemy(whiteBloodCell: enemy, scene: self)
//        enemy2.CreateEnemy()
//        enemy2.CheckDirection()
//        enemy2.startMove = enemy1.directionTrue.randomElement()
//        enemy2.MoveEnemy()
//    }
}

*/


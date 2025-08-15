//
//  MazeScene.swift
//  lab9UITests
//
//  Created by Yatin parulkar on 2025-08-15.
//

import SpriteKit

class MazeScene: SKScene {
    private let tileSize = CGSize(width: 40, height: 40)
    private var mazeGrid: [[Int]] = []
    private let rows = 10
    private let cols = 10
    
    private var player: SKShapeNode!
    private var goal: SKShapeNode!
    
    // Maze legend: 0 = path, 1 = wall
    // Simple hardcoded maze layout
    private let mazeLayout: [[Int]] = [
        [1,1,1,1,1,1,1,1,1,1],
        [1,0,0,0,1,0,0,0,0,1],
        [1,0,1,0,1,0,1,1,0,1],
        [1,0,1,0,0,0,0,1,0,1],
        [1,0,1,1,1,1,0,1,0,1],
        [1,0,0,0,0,1,0,1,0,1],
        [1,1,1,1,0,1,0,1,0,1],
        [1,0,0,1,0,0,0,0,0,1],
        [1,0,1,1,1,1,1,1,0,1],
        [1,1,1,1,1,1,1,1,1,1]
    ]
    
    // Current player position in grid coordinates (row,col)
    private var playerGridPos = (row: 1, col: 1)
    private var goalGridPos = (row: 7, col: 8)
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        mazeGrid = mazeLayout
        
        drawMaze()
        addPlayer()
        addGoal()
    }
    
    func drawMaze() {
        for row in 0..<rows {
            for col in 0..<cols {
                let tile = mazeGrid[row][col]
                let rect = CGRect(
                    x: CGFloat(col) * tileSize.width,
                    y: CGFloat(rows - 1 - row) * tileSize.height,
                    width: tileSize.width,
                    height: tileSize.height)
                
                let node = SKShapeNode(rect: rect)
                node.strokeColor = .clear
                node.fillColor = tile == 1 ? .darkGray : .white
                addChild(node)
            }
        }
    }
    
    func addPlayer() {
        let pos = pointForGrid(row: playerGridPos.row, col: playerGridPos.col)
        player = SKShapeNode(circleOfRadius: tileSize.width * 0.4)
        player.fillColor = .systemBlue
        player.position = pos
        player.zPosition = 10
        addChild(player)
    }
    
    func addGoal() {
        let pos = pointForGrid(row: goalGridPos.row, col: goalGridPos.col)
        goal = SKShapeNode(rectOf: CGSize(width: tileSize.width * 0.8, height: tileSize.height * 0.8), cornerRadius: 6)
        goal.fillColor = .systemGreen
        goal.position = pos
        goal.zPosition = 5
        addChild(goal)
    }
    
    func pointForGrid(row: Int, col: Int) -> CGPoint {
        // Convert grid coordinates to scene coordinates
        let x = CGFloat(col) * tileSize.width + tileSize.width / 2
        let y = CGFloat(rows - 1 - row) * tileSize.height + tileSize.height / 2
        return CGPoint(x: x, y: y)
    }
    
    func gridForPoint(_ point: CGPoint) -> (row: Int, col: Int) {
        let col = Int(point.x / tileSize.width)
        let row = rows - 1 - Int(point.y / tileSize.height)
        return (row, col)
    }
    
    // MARK: - Movement Logic
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        movePlayerToward(point: touchLocation)
    }
    
    func movePlayerToward(point: CGPoint) {
        let playerPos = player.position
        let dx = point.x - playerPos.x
        let dy = point.y - playerPos.y
        
        // Determine direction to move: only up/down/left/right one tile at a time
        var nextRow = playerGridPos.row
        var nextCol = playerGridPos.col
        
        if abs(dx) > abs(dy) {
            // Horizontal move
            if dx > 0 { nextCol += 1 } else { nextCol -= 1 }
        } else {
            // Vertical move
            if dy > 0 { nextRow -= 1 } else { nextRow += 1 }
        }
        
        // Check bounds and collision with walls
        if nextRow >= 0 && nextRow < rows && nextCol >= 0 && nextCol < cols {
            if mazeGrid[nextRow][nextCol] == 0 {
                movePlayerTo(row: nextRow, col: nextCol)
            }
        }
    }
    
    func movePlayerTo(row: Int, col: Int) {
        playerGridPos = (row, col)
        let newPosition = pointForGrid(row: row, col: col)
        let moveAction = SKAction.move(to: newPosition, duration: 0.2)
        player.run(moveAction) { [weak self] in
            self?.checkGoalReached()
        }
    }
    
    func checkGoalReached() {
        if playerGridPos == goalGridPos {
            showWinMessage()
        }
    }
    
    func showWinMessage() {
        let label = SKLabelNode(text: "You Escaped! 🎉")
        label.fontSize = 40
        label.fontColor = .systemYellow
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        label.zPosition = 20
        addChild(label)
        
        // Disable further touches after win
        isUserInteractionEnabled = false
    }
}

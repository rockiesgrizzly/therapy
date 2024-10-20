struct TasksCompleted {
    var breath = false
    var waiting = false
    var session = false
    var mood = false
    
    var allComplete : Bool {
        return breath && mood && waiting && session
    }
}

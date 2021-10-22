import UIKit

struct Operation1 {
    func task1(){
        print("Operation 1")
        Thread.sleep(forTimeInterval: 3)
        print("Operation 1 completed!")
    }
}

struct Operation2 {
    func task2(){
        print("Operation 2")
        Thread.sleep(forTimeInterval: 3)
        print("Operation 2 completed!")
    }
}

struct Operation3 {
    func task3(){
        print("Operation 3")
        Thread.sleep(forTimeInterval: 3)
        print("Operation 3 completed!")
    }
}

struct SyncManager {
    func sync(){
        let op1 = BlockOperation()
        
        op1.addExecutionBlock {
            let operator1 = Operation1()
            operator1.task1()
        }
        
        let op2 = BlockOperation()
        
        op2.addExecutionBlock {
            let operator2 = Operation2()
            operator2.task2()
        }
        
        let op3 = BlockOperation()

        op3.addExecutionBlock {
            let operator3 = Operation3()
            operator3.task3()
        }
        op3.addDependency(op1)
        op1.addDependency(op2)

        let operationQue = OperationQueue()
        operationQue.addOperation(op1)
        operationQue.addOperation(op2)
        operationQue.addOperation(op3)
    }
}

let syncManager = SyncManager()
syncManager.sync()


DispatchQueue.global().async  {
    print("asyn task 1")
}
DispatchQueue.global().async  {
    print("asyn task 2")
}
DispatchQueue.global().async  {
    print("asyn task 3")
}

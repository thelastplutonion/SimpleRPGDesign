import Foundation

struct GlobalVaraibles {
    static var jobList : [String] = ["Ranger", "Wizard"]
    static var speciesList : [String] = ["Human", "Elf", "Orc", "Fae", "Demoni", "Angeli", "Dwarf", "Treant", "Beastmen"]

    static func GenerateJob(name: String) -> Job{
        let type = name
         switch type {
        case "Ranger":
            return Ranger()
        case "Wizard":
            return Wizard()
        default:
            return TestJob()
        }
    }

    static func GenerateSpecies(name: String) -> Species{
        let type = name
        switch type {
            case "Human":
                return Human()
            case "Elf":
                return Elf()
            case "Orc":
                return Orc()
            case "Fae":
                return Fae()
            case "Demoni":
                return Demoni()
            case "Angeli":
                return Angeli()
            case "Dwarf":
                return Dwarf()
            case "Treant":
                return Treant()
            case "Beastmen":
                return Beastmen()
                
            default:     
                return DefaultSpecies()
        }
    }

   static func StatGenerator(max: Double) -> Double{
        var result = max
        result = round(Double.random(in: 1...max))
        return result
    }
}

// Logic for the Character Jobs

class Job{
    let name: String
    let growthRates: [Double]

    enum Archetypes {

    }
    init(name: String, growthRates: [Double]){
        self.name = name
        self.growthRates = growthRates
    }
}
class Ranger: Job{
    init(){
        super.init(name: "Ranger", growthRates: [60,45,40,30,30,30,30,30,30,30,30,30])
    }
}
class Wizard: Job{
    init(){
        super.init(name: "Wizard", growthRates: [30,50,10,10,20,20,20,20,10,10,10,10])
        
    }
}
class TestJob: Job{
    init(){
        super.init(name: "Null", growthRates: [10,10,10,10,20,20,20,20,10,10,10,10])
    }
}

// Logic for the Character Species

class Species{
    let name: String
    let growthRates: [Double]

    init(name: String, growthRates: [Double]){
        self.name = name
        self.growthRates = growthRates
    }
}
class Human: Species{
    init(){
        super.init(name: "Human", growthRates: [15.0,15.0,15.0,15.0,15.0,15.0,15.0,15.0,15.0,15.0,15.0,15.0])
    }
}
class Treant: Species{
    init(){
        super.init(name: "Treant", growthRates: [10, 10, 0, 20, 15, 10, 10, 20, 15, 15, 20, 5])
    }
}
class Fae: Species{
    init(){
        super.init(name: "Fae", growthRates: [10, 0, 15, 10, 20, 20, 20, 5,	10,	15,	15,	20])
    }
}
class Angeli: Species{
    init(){
        super.init(name: "Angeli", growthRates: [15,20,	10,	20,	0, 20, 15, 10, 10, 5, 15, 10])
    }
}
class Demoni: Species{
    init(){
        super.init(name: "Demoni", growthRates: [10, 15, 10, 10, 20, 0, 20, 10, 15, 20, 5, 15]) 
    }
}
class Dwarf: Species{
    init(){
        super.init(name: "Dwarf", growthRates: [15, 15,	5,	20,	10,	15,	20,	0,	20,	10,	10,	10])
    }
}
class Elf: Species{
    init(){
        super.init(name: "Elf", growthRates: [10.0,10.0,20.0,10.0,20.0,10.0,15.0,5.0,20,15,15,0])
    }
}
class Orc: Species{
    init(){
        super.init(name: "Orc", growthRates: [20.0,20.0,10.0,20.0, 10.0,10.0,15.0,15,  5,0,15,10 ])
    }
}
class Beastmen: Species{
    init(){
        super.init(name: "Beastmen", growthRates: [15, 20, 20, 15, 10, 5, 0, 20, 10, 10, 10, 15])
    }
}
class DefaultSpecies: Species{
    init(){
        super.init(name: "Null", growthRates: [150.0,50,10,10,20,20,20,20,10,10,10,10])
    }
}

class Character{
    var name = ""
    var level = 1
    var health : Double = 0, maxHealth: Double = 0

    var jobName: String = "", speciesName: String = "Elf"
    var primaryJob : Job = TestJob()
    var species : Species = DefaultSpecies()
    var attributes = [("Vigor", 5.0),("Strength", 5.0), ("Dexterity", 5.0), ("Durability", 5.0),
                    ("Faith", 5.0), ("Arcane", 5.0), ("Mind", 5.0) , ("Primal", 5.0),
                    ("Intelligence", 5.0), ("Luck", 5.0), ("Will", 5.0), ("Charm", 5.0)]
    var specGR: [Double] = [10,10,10,10,10,10,10,10,10,10,10,10]
    var totGR: [Double] = []


    init(){
        Generate()
    }

    func Generate(){
        speciesName = GlobalVaraibles.speciesList.randomElement()!
        species = GlobalVaraibles.GenerateSpecies(name: speciesName)
        jobName = GlobalVaraibles.jobList.randomElement()!
        primaryJob = GlobalVaraibles.GenerateJob(name: jobName)

//Assigns total growth rates for a character
        for i: Int in 0...11{
            totGR.append(Double(species.growthRates[i]) + Double(primaryJob.growthRates[i]))
        }
        print("Species: \(species.name)")
        print("Job: \(primaryJob.name)")
        // print("Species GR: \(species.growthRates)")
        // print("Job GR: \(primaryJob.growthRates)")
        print("Character Growth Rates: \(totGR)")

    }

//System to level up the character, adjust their level as well as their stats
    func LevelUp(){
        self.level += 1
         var checker = 0.0
        print("Congratualtions you have reached lvl \(self.level)")
        for i in 0...11{
             checker =  GlobalVaraibles.StatGenerator(max: 100) + totGR[i]
             //print("Checker \(i) \(checker)")
             while(checker >= 100){
                self.attributes[i].1 += 1.0
                checker -= 100
             }
             checker = 0.0
          print(self.attributes[i].1)
        }
              
    }

}

let toz : Character = Character()
toz.LevelUp()
toz.LevelUp()
toz.LevelUp()
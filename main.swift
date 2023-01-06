import Foundation
func StatGenerator(max: Double) -> Double{
    var result = max
    result = round(Double.random(in: 1...max))

    return result
}

class Job{
    let name: String
    let growthRates: [Double]

    init(name: String, growthRates: [Double]){
        self.name = name
        self.growthRates = growthRates
    }
}

class Ranger: Job{
    init(){
        super.init(name: "Ranger", growthRates: [10,10,40,10,10,10,10,10,10,10,10,10])
    }
}

class Wizard: Job{
    init(){
        super.init(name: "Wizard", growthRates: [150,50,10,10,20,20,20,20,10,10,10,10])
    }
}

class TestJob: Job{
    init(){
        super.init(name: "Null", growthRates: [10,10,10,10,20,20,20,20,10,10,10,10])
    }
}

func GenerateJob(name: String) -> Job{
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
        super.init(name: "Human", growthRates: [10.0,10,10,10,10,10,10,10,10,10,10,10])
    }
}

class Elf: Species{
    init(){
        super.init(name: "Elf", growthRates: [10.0,30,30,30,10,10,10,10,10,10,10,10])
    }
}

class DefaultSpecies: Species{
    init(){
        super.init(name: "Null", growthRates: [150.0,50,10,10,20,20,20,20,10,10,10,10])
    }
}

func GenerateSpecies(name: String) -> Species{
    let type = name
    switch type {
        case "Human":
            return Human()
        case "Elf":
            return Elf()
        default:
            return DefaultSpecies()
    }
}

let job_ranger = Ranger()

class Character{
    var name = ""
    var level = 1
    var jobName = "", speciesName = "Elf"
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
        speciesName = SpeciesRandomizer()
        species = GenerateSpecies(name: speciesName)
        jobName = JobRandomizer()
        primaryJob = GenerateJob(name: jobName)

        //Assigns total growth rates for a character
        for i: Int in 0...11{
            totGR.append(Double(species.growthRates[i]) + Double(primaryJob.growthRates[i]))
        }
        print("Species: \(species.name)")
        print("Job: \(primaryJob.name)")
        print("Species GR: \(species.growthRates)")
        print("Job GR: \(primaryJob.growthRates)")
        print("Total GR: \(totGR)")

        func JobRandomizer() -> String{
            let jobList = ["Wizard", "Ranger"]
            let selectedJob = jobList.randomElement()!
            return selectedJob
        }

        func SpeciesRandomizer() -> String{
            let speciesList = ["Human", "Elf"]
            let selectedSpecies = speciesList.randomElement()!
            return selectedSpecies
        }
    }

//System to level up the character, adjust their level as well as their stats
    func LevelUp(){
        self.level += 1
         var checker = 0.0
        print("Congratualtions you have reached lvl \(self.level)")
        for i in 0...11{
             checker = StatGenerator(max: 100) + totGR[i]
             //print("Checker \(i) \(checker)")
             while(checker >= 100){
                self.attributes[i].1 += 1.0
                checker -= 100
             }
             checker = 0.0
        }
        print(self.attributes[0].1)
    }

}

let toz : Character = Character()


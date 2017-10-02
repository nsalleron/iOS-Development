//
//  QuestionsReponses.swift
//  Quizz
//
//  Created by Nicolas Salleron on 02/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import Foundation

class QuestionsReponses {
    
    let questionRep = [0:["SOFT","«Vous n’avez pas le monopole du coeur.» À qui Valéry Giscard d’Estaing s'adresse-t-il ?", "François Mitterand"],
                       1:["SOFT","Quelle entreprise, fondée par Jack Ma, domine le commerce électronique en Chine  ?","Alibaba"],
                       2:["HARD","À quel ordre de l’église catholique appartient le pape François ?","Les jésuites"],
                       3:["SOFT","Quel roi était surnommé le “Roi-Soleil” ?","Louis Croix Baton V"],
                       4:["SOFT","Quelle est la couleur du rubis ?","Rouge"],
                       5:["SOFT","À quel groupe doit-on « In the navy » the 1978 ?","Village People"],
                       6:["HARD","Quel philosophe a écrit \" Les origines du totalitarisme \" et \" La crise de la culture \" ?","Hannah Arendt"],
                       7:["SOFT","Quel pays a interdit la construction de minaret après un referendum en 2009 ?","La Suisse"],
                       8:["SOFT","Qui incarne Cyrano de Bergerac dans le film éponyme de 1990 ?","Gérard Depardieu"],
                       9:["SOFT","Dans quel roman de Victor Hugo trouve-t-on le personnage de Quasimodo ?","Notre-Dame-De-Paris"],
                       10:["HARD","Quel animal est la drosophile, utilisée dans des expérimentations génétiques ?","Une mouche"],
                       11:["SOFT","Quelle est la capitale de la Suède ?","Stockholm"],
                       12:["HARD","De quel ouvrage de la Bible est tiré l’expression “rien de nouveau sous le Soleil” ?","L'Ecclésiaste"]]
    
    var repAfficher = 0
    var currentIndex = 0
    var modeHard = false
   
    func getQuestion(index : Int) -> [String] {
        return questionRep[index%questionRep.count]!
    }
    
    func getReponse(question: Int) -> String{
        return questionRep[question%questionRep.count]![2]
    }
    
    func incNbQuestion(){
        repAfficher+=1
    }
    func getNbReponseVue()->Int{
        return repAfficher
    }
    
    func getNbMax()->Int{
        return questionRep.count
    }
    
    
}

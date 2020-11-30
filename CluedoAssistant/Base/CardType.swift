//
//  CardType.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 07.11.2020.
//

import Foundation

enum CardType: CaseIterable, Equatable {

    case hero(Hero)
    case weapon(Weapon)
    case room(Room)
    
    static var allCases: [CardType] {
        
        return [
            .hero(.blue),
            .hero(.green),
            .hero(.red),
            .hero(.violet),
            .hero(.yellow),
            .hero(.white),
            
            .room(.bathRoom),
            .room(.diningRoom),
            .room(.guestHouse),
            .room(.hallway),
            .room(.livingRoom),
            .room(.kitchen),
            .room(.observatory),
            .room(.showRoom),
            .room(.terrace),
            
            .weapon(.ax),
            .weapon(.bit),
            .weapon(.chandelier),
            .weapon(.dumbbell),
            .weapon(.knife),
            .weapon(.pistol),
            .weapon(.poison),
            .weapon(.rope),
            .weapon(.trophy),
            
        ]
    }
    
    var onlyType: String {
        
        switch self {
        
        case .hero : return String(describing: Hero.self)
        case .room : return String(describing: Room.self)
        case .weapon : return String(describing: Weapon.self)
        }
    }

    var value: String {
        
        switch self {
        
        case .hero(.blue):
            return String(describing: Hero.blue)
        case .hero(.green):
            return String(describing: Hero.green)
        case .hero(.red):
            return String(describing: Hero.red)
        case .hero(.violet):
            return String(describing: Hero.violet)
        case .hero(.white):
            return String(describing: Hero.white)
        case .hero(.yellow):
            return String(describing: Hero.yellow)
            
        case .weapon(.ax):
            return String(describing: Weapon.ax)
        case .weapon(.bit):
            return String(describing: Weapon.bit)
        case .weapon(.chandelier):
            return String(describing: Weapon.chandelier)
        case .weapon(.dumbbell):
            return String(describing: Weapon.dumbbell)
        case .weapon(.knife):
            return String(describing: Weapon.knife)
        case .weapon(.pistol):
            return String(describing: Weapon.pistol)
        case .weapon(.poison):
            return String(describing: Weapon.poison)
        case .weapon(.rope):
            return String(describing: Weapon.rope)
        case .weapon(.trophy):
            return String(describing: Weapon.trophy)
            
        case .room(.bathRoom):
            return String(describing: Room.bathRoom)
        case .room(.diningRoom):
            return String(describing: Room.diningRoom)
        case .room(.guestHouse):
            return String(describing: Room.guestHouse)
        case .room(.hallway):
            return String(describing: Room.hallway)
        case .room(.kitchen):
            return String(describing: Room.kitchen)
        case .room(.livingRoom):
            return String(describing: Room.livingRoom)
        case .room(.observatory):
            return String(describing: Room.observatory)
        case .room(.showRoom):
            return String(describing: Room.showRoom)
        case .room(.terrace):
            return String(describing: Room.terrace)

        }
    }
}




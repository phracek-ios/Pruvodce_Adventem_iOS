//
//  AdventData.swift
//  Průvodce Adventem
//
//  Created by Ludek Strobl on 20/04/2020.
//  Copyright © 2020 Biskupství Brněnské. All rights reserved.
//

import Foundation

extension StringProtocol {
     var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
     
 }

class AdventData {

 
    
    var dataArray = [String]()
        
           
    func adventLastDayDate() -> Date? {
        let date = Date()
        var dateComponents  = DateComponents()
        let formater = DateFormatter()
        formater.dateFormat = "yyyy"
        dateComponents.month = 12
        dateComponents.day = 24
        dateComponents.year = Int(formater.string(from: date))
        let calendar = Calendar.current
        let advent = calendar.date(from: dateComponents)
        return advent
    }
    

    func getAdventFirstDayDate() -> Date? {

        let calendar = Calendar.current
        var advent = adventLastDayDate()
        while calendar.component(.weekday, from: advent!) != 1 {
            advent = calendar.date(byAdding: .day, value: -1, to: advent!)
            }
        if calendar.component(.weekday, from: advent!) == 1 {
            advent = calendar.date(byAdding: .day, value: -21, to: advent!)
            }
        return advent
    }


    func formatujDatum(_ date:Date?) -> String {
             
             let formater = DateFormatter()
            formater.locale = Locale(identifier: Locale.preferredLanguages[0])
                          
            formater.dateFormat = ("d. MMMM yyyy")
             let datum = formater.string(from: date!)
             return datum
         }
         
    func weekdayName(_ weekdayNumber: Int) -> String {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: Locale.preferredLanguages[0])
        let weekdaySymbols = calendar.weekdaySymbols
        return weekdaySymbols[weekdayNumber-1]
    }


    func zobrazeniDatTabulky() {
        
        dataArray.removeAll()
        let date = Date() + 7*60*60
        let adventFirstDate = getAdventFirstDayDate()!
        let adventLastDate = adventLastDayDate()!
        
        let calendar = Calendar.current
        var odZacatkuDoTed = calendar.dateComponents([.day], from: adventFirstDate, to: date ).day!
        let pocetDniAdventu = calendar.dateComponents([.day], from: adventFirstDate, to: adventLastDate ).day!
        if date < adventFirstDate {
            odZacatkuDoTed = -1
        }
        
        
        if odZacatkuDoTed >= 0 && odZacatkuDoTed-pocetDniAdventu <= 15 {
            var zacatek = 0
            if odZacatkuDoTed - pocetDniAdventu < 0 {
                zacatek = 0
            }
          
            else {
                zacatek = odZacatkuDoTed - pocetDniAdventu
            }
            for i in zacatek...odZacatkuDoTed{
                let modifiedDate = Calendar.current.date(byAdding: .day, value: -i, to: date)
                
                
                dataArray.append("\(weekdayName(calendar.component(.weekday, from: modifiedDate!))),  \(formatujDatum(modifiedDate))".firstUppercased)
        
            }
          
        }
      
    }
    
    func poleTextu(_ texty:[String]) -> [String]{
        
        let date = Date() + 7*60*60
        let adventFirstDate = getAdventFirstDayDate()!
        let adventLastDate = adventLastDayDate()!
        
        let calendar = Calendar.current
        let odZacatkuDoTed = calendar.dateComponents([.day], from: adventFirstDate, to: date ).day!
        let pocetDniAdventu = calendar.dateComponents([.day], from: adventFirstDate, to: adventLastDate ).day!
        
        var poleTextu = texty
        
        poleTextu.removeLast(texty.count - pocetDniAdventu - 1)
        if pocetDniAdventu > odZacatkuDoTed {
            poleTextu.removeLast(pocetDniAdventu - odZacatkuDoTed)
        }
        
        poleTextu.reverse()
        
        return poleTextu
    }
    
}

//
//  HelpViewModel.swift
//  Please
//
//  Created by Sophie Brand on 17.05.25.
//

import Foundation

class HelpViewModel {
    var titles = ["Der Text:", "Das Diagramm: ", "Das Balkendiagramm: "]
    var discriptions = ["Der Text bildet eine kontrafraktische Erklärung ab. Es beschreibt, welche Merkmale des Films verändert werden müssten, um eine höhere oder niedrigere Bewertung zu erhalten.", "Das Diagramm zeigt die Merkmale des Films, die sich positiv auf die Bewertung ausgewirkt haben.","Das Diagramm zeigt die Merkmale des Films, die sich positiv oder negativ auf die Bewertung ausgewirkt haben." ]
    var stichpoints = ["• Es wird genannt, welche Merkmale (z.B. 'Serie', 'Animation') hinzugefügt oder entfernt werden müssten. \n\nKurz gesagt:„Was müsste anders sein, damit das Ergebnis anders wird?“", "• Jede Farbe steht für ein Merkmal. \n• Die Größe des Balken und der Wert der X-Achse geben den Einfluss des Merkmals an. \n• Hinweis: Ein Merkmal kann sich sowohl durch seine Anwesenheit als auch durch seine Abwesenheit positiv auswirken.", "• Y-Achse: Merkmalsausprägung \n• Die einzelnen Balken stehen für die wichtigsten Merkmale der Entscheidungsfindung. \n• Werte unter 1.0 (z. B. Genre ≤ 1.0) zeigen den Einfluss des Merkmals, wenn es nicht vorhanden ist. \n• Werte über 0.0 (z. B. Genre ≥ 0.0) zeigen den Einfluss des Merkmals, wenn es vorhanden ist. \nDie Bedeutung hängt vom X-Wert und der Richtung des Balkens ab. \n\n• X-Achse: Zeigt den Wert des Einflusses eines Merkmals \n• Grüne Balken zeigen Merkmale mit einem positiven Einfluss auf die Bewertung. \n• Rote Balken zeigen Merkmale mit einem negativen Einfluss.\n• Je länger der Balken, desto stärker der Einfluss des jeweiligen Merkmals auf die Vorhersage des Modells." ]
    var images = ["text", "diagramm", "barChart"]
}

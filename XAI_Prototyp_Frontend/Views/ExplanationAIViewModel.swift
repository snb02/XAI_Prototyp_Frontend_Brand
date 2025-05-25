//
//  ExplanationAIViewModel.swift
//  Please
//
//  Created by Sophie Brand on 17.05.25.
//

import Foundation

class ExplanationAIViewModel {
    var titles = ["Schritt 1: Datensammlung", "Schritt 2: Ein Modell trainieren", "Schritt 3: Das Modell anwenden"]
    var discriptions = ["• Eine Sammlung von Daten wird benötigt, wie zum Beispiel Bilder, Texte, Zahlen oder andere Informationen. Diese sollten alle Varianten der gewünschten KI-Aufgabe abdecken, um dem System eine umfassende Grundlage für das Training zu bieten.", "• Mithilfe von Algorithmen wird ein Modell erstellt und trainiert, das Muster und Zusammenhänge zwischen den Informationen (Merkmalen) und einer Zielvariable erkennt. Das Modell lernt, welche Merkmale wichtig sind, um präzise Vorhersagen oder Entscheidungen zu treffen.", "• Nach dem Training können die gelernten Muster auf neue und unbekannte Daten angewendet werden, um beispielsweise Vorhersagen zu treffen oder Probleme zu lösen, je nach der spezifischen KI-Aufgabe."]
    //https://www.flaticon.com/de/kostenloses-icon/datensammlung_3270865
    //https://www.flaticon.com/de/kostenloses-icon/modell_1310124
    //https://www.flaticon.com/de/kostenloses-icon/tiefes-lernen_4882508
    var images = ["dataCollection", "pattern", "applyModel"]
    var examples = [
        """
        Ein Datensatz in Form einer Tabelle, in der Filmdaten gespeichert sind. Folgende Merkmale könnten enthalten sein: Titel, Genre, Typ, Thema, Erscheinungsjahr und Bewertung.
        """,
        """
        Ein Modell lernt ein Muster: Immer wenn das Genre "Action" ist, ist die Bewertung hoch.
        """,
        """
        Ein Film mit den Merkmalen (Action, Lustig, 2002) wird in das Modell eingegeben. Das Modell wendet die erlernten Regeln an, dass Actionfilme hoch bewertet werden, und gibt eine Bewertung von 9,5 aus.
        """
    ]
}

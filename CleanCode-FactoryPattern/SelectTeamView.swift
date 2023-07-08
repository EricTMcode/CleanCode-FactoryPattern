//
//  SelectTeamView.swift
//  CleanCode-FactoryPattern
//
//  Created by Eric on 08/07/2023.
//

import SwiftUI

enum PlayerType: String {
    case pointGard, center
    
    var text: String {
        switch self {
        case .pointGard:
            return "Point Guard"
        case .center:
            return "Center"
        }
    }
}

protocol Player {
    var playerType: PlayerType { get }
    func shoot()
}

struct Center: Player {
    let playerType: PlayerType = .center
    
    func shoot() {
        // Logic for shooting center
        print("Center shoots")
    }
}

struct PointGuard: Player {
    let playerType: PlayerType = .pointGard
    
    func shoot() {
        // Logic for shooting point guard
        print("Point guard shoots")
    }
}

class PlayerFactory {
    func makePlayer(playerType: PlayerType) -> Player {
        switch playerType {
        case .pointGard:
            return PointGuard()
        case .center:
            return Center()
        }
    }
}

struct SelectTeamView: View {
    let factory = PlayerFactory()
    @State private var players: [Player] = []
    
    var body: some View {
        VStack {
            VStack {
                ForEach(0..<players.count, id: \.self) { index in
                    VStack {
                        Text("\(players[index].playerType.text)")
                    }
                }
            }
            Spacer()
            HStack {
                Button("Point Guard") {
                    let player = factory.makePlayer(playerType: .pointGard)
                    players.append(player)
                }
                Button("Center") {
                    let player = factory.makePlayer(playerType: .center)
                    players.append(player)
                }
            }
            .buttonStyle(.bordered)
        }
    }
}

struct SelectTeamView_Previews: PreviewProvider {
    static var previews: some View {
        SelectTeamView()
    }
}

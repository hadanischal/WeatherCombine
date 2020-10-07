//
//  WeatherListCell.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 4/10/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import SwiftUI

struct WeatherListCell: View {
    private let viewModel: WeatherListDTO

    init(viewModel: WeatherListDTO) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack {
                    Text("\(viewModel.name)")
                        .foregroundColor(.black)
                        .font(.title)
                    Spacer()
                    Text("\(viewModel.temperature)°C")
                        .foregroundColor(.black)
                        .font(.title)
                }
                .padding(10)
            }
        }
    }
}

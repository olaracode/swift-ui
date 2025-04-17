struct HomePlantCardView: View {
    let plant: PlantModel
    
    var body: some View{
        HStack {
           
            Image("philodendron")
                .resizable()
                .frame(width: 100, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 12))
               
            
            VStack(alignment: .leading) {
                
                HStack(alignment: .center) {
                    Text(plant.name)
                        .font(.title)
                    HStack(alignment: .center) {
                        Text(plant.status.label) // or "Need watering"
                            .font(.caption)
                        Circle()
                            .frame(width: 9, height: 9)
                            .foregroundColor(plant.status.color)
                    }
                }
                Text(plant.location.label)
                
            }

            Spacer()
        }
        .padding()
        .background()
        .cornerRadius(16)
        .shadow(radius: 0.8)
        .containerRelativeFrame(.horizontal)
    }
}
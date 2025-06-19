import SwiftUI

struct DayLogCalendarView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            DatePicker(
                "Select Date",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding()
            
            Text("Selected Date: \(selectedDate, formatter: dateFormatter)")
                .font(.headline)
                .padding()
            
            Spacer()
        }
        .padding()
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
}()

#Preview {
    DayLogCalendarView()
}

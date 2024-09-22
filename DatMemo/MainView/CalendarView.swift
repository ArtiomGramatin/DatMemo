import SwiftUI

struct CalendarView: View {
    let backgroundBlur = Image("backgroundblur")
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    @State private var currentDate = Date()
    @ObservedObject var yourchoice: yourchosencat
    @ObservedObject var username: Username
    @ObservedObject var partnersname: Partnersname
    @ObservedObject var partnerschosencat: partnerschosencat
    @State private var completedDates: Set<Date> = []

    private func imageName(for date: Date) -> String {
        if completedDates.contains(date) {
            return "completeddateicon"
        } else {
            return "backgrounddaybuttonimage"
        }
    }

    private func catImageName(for catChoice: Int8) -> String {
        switch catChoice {
        case 1: return "artiomkaCatChoosingButton"
        case 2: return "sashenkaCatChoosingButton"
        case 3: return "dimaCatChoosingButton"
        default: return "ChooseButtonCats"
        }
    }

    private var calendar: Calendar {
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        return calendar
    }

    private var monthName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: currentDate)
    }

    private var year: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: currentDate)
    }

    private var daysInMonth: [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: currentDate) else { return [] }
        let startDate = monthInterval.start

        let firstWeekday = calendar.component(.weekday, from: startDate)
        let paddingDays = (firstWeekday - calendar.firstWeekday + 7) % 7

        let adjustedStartDate = calendar.date(byAdding: .day, value: -paddingDays, to: startDate)!

        let range = paddingDays + calendar.range(of: .day, in: .month, for: currentDate)!.count
        return (0..<range).compactMap {
            calendar.date(byAdding: .day, value: $0, to: adjustedStartDate)
        }
    }

    private func dayOfMonth(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }

    private func isCurrentMonth(date: Date) -> Bool {
        return calendar.isDate(date, equalTo: currentDate, toGranularity: .month)
    }

    private func moveMonth(by months: Int) {
        if let newDate = calendar.date(byAdding: .month, value: months, to: currentDate) {
            currentDate = newDate
        }
    }

    private func saveCompletedDates() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(Array(completedDates)) {
            UserDefaults.standard.set(encoded, forKey: "CompletedDates")
        }
    }

    private func loadCompletedDates() {
        if let data = UserDefaults.standard.data(forKey: "CompletedDates") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Date].self, from: data) {
                completedDates = Set(decoded)
            }
        }
    }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let isSmallDevice = geometry.size.height < 667
                ZStack {
                    backgroundBlur
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()

                    VStack {
                        HStack {
                            Spacer()
                            NavigationLink(destination: Profile(yourchoice: yourchoice, username: username, partnersname: partnersname, partnerschosencat: partnerschosencat)) {
                                Image(catImageName(for: yourchoice.ychosenCat))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .shadow(color: .shadowblack, radius: 0, x: 6, y: 5)
                                    .frame(width: geometry.size.width * (isSmallDevice ? 0.15 : 0.18), height: geometry.size.width * (isSmallDevice ? 0.15 : 0.18))
                            }
                            .padding(.trailing, geometry.size.width * 0.05)
                        }
                        .padding(.top, geometry.size.height * (isSmallDevice ? 0.03 : 0.05))

                        Spacer()

                        ZStack {
                            Image("calendarviewimg")
                                .resizable()
                                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.7)
                                .shadow(color: .shadowblack, radius: 0, x: 6, y: 5)
                                .offset(y: -geometry.size.height * 0.05)

                            VStack {
                                HStack {
                                    Button(action: {
                                        moveMonth(by: -1)
                                    }) {
                                        Image("arrowleft")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: geometry.size.width * (isSmallDevice ? 0.05 : 0.06), height: geometry.size.width * (isSmallDevice ? 0.04 : 0.05))
                                            .shadow(color: .shadowblack, radius: 0, x: 6, y: 5)
                                    }

                                    Spacer()

                                    ZStack {
                                        Image("monthbutton")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: geometry.size.width * (isSmallDevice ? 0.6 : 0.7), height: geometry.size.height * 0.09)
                                            .shadow(color: .shadowblack, radius: 0, x: 6, y: 5)

                                        Text(monthName)
                                            .font(Font.custom("PressStart2P", size: geometry.size.width * (isSmallDevice ? 0.04 : 0.05)))
                                            .foregroundColor(.brownnr2)
                                    }

                                    Spacer()

                                    Button(action: {
                                        moveMonth(by: 1)
                                    }) {
                                        Image("arrowright")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: geometry.size.width * (isSmallDevice ? 0.05 : 0.06), height: geometry.size.width * (isSmallDevice ? 0.04 : 0.05))
                                            .shadow(color: .shadowblack, radius: 0, x: 6, y: 5)
                                    }
                                }
                                .padding(.horizontal)

                                ZStack {
                                    Image("year")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.05)
                                    Text(year)
                                        .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.05)
                                        .font(Font.custom("PressStart2P", size: geometry.size.width * (isSmallDevice ? 0.03 : 0.04)))
                                        .foregroundColor(.white)
                                        .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)
                                }
                                .padding(.vertical, geometry.size.height * 0.01)

                                VStack(spacing: geometry.size.height * 0.01) {
                                    HStack(spacing: geometry.size.width * 0.02) {
                                        ForEach(["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"], id: \.self) { day in
                                            Text(day)
                                                .font(Font.custom("PressStart2P", size: geometry.size.width * 0.03))
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity)
                                                .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)
                                        }
                                    }

                                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: geometry.size.width * 0.015), count: 7), spacing: geometry.size.height * 0.015) {
                                        ForEach(daysInMonth, id: \.self) { date in
                                            NavigationLink(destination: DayView(date: date, yourchoice: yourchoice, username: username, partnersname: partnersname, partnerschosencat: partnerschosencat, onSaveContent: { savedDate in
                                                completedDates.insert(savedDate)
                                                saveCompletedDates()
                                            })
                                            .navigationBarHidden(true)
                                            .navigationBarBackButtonHidden(true))
                                            {
                                                ZStack {
                                                    Image(imageName(for: date))
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: geometry.size.width * (isSmallDevice ? 0.08 : 0.095), height: geometry.size.width * (isSmallDevice ? 0.08 : 0.095))
                                                        .shadow(color: .shadowblack, radius: 0, x: 2, y: 3)
                                                        .opacity(isCurrentMonth(date: date) ? 1 : 0.3) // Change opacity for non-current month days

                                                    Text(dayOfMonth(date: date))
                                                        .font(Font.custom("PressStart2P", size: geometry.size.width * (isSmallDevice ? 0.03 : 0.04)))
                                                        .foregroundColor(.white)
                                                        .shadow(color: .shadowblack, radius: 0, x: 4, y: 3)
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal, geometry.size.width * 0.05)
                            }
                            .padding(.horizontal)
                            .padding(.bottom, geometry.size.width * (isSmallDevice ? 0.3 : 0.4))
                        }

                        Spacer()
                    }
                }
                .onAppear {
                    AudioManager.shared.configureAudioSession()
                    loadCompletedDates()
                }
                .onDisappear {
                    AudioManager.shared.deactivateAudioSession()
                }
                .frame(width: geometry.size.width)
                .aspectRatio(contentMode: .fill)
                .navigationBarHidden(true)
                .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                    if value.startLocation.x < 20 && value.translation.width > 100 {
                        self.mode.wrappedValue.dismiss()
                    }
                }))
            }
        }
    }
}

#Preview{
    CalendarView(yourchoice: yourchosencat(), username: Username(), partnersname: Partnersname(), partnerschosencat: partnerschosencat())
}

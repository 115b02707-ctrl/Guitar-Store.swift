import SwiftUI

struct Guitar: Identifiable {
    let id = UUID()
    let name: String
    let subtitle: String
    let price: String
    let imageURL: String
    let tag: String
}

struct ContentView: View {
    @State private var cartCount = 0
    @State private var selectedCategory = "全部"

    private let categories = ["全部", "木吉他", "電吉他", "配件"]
    private let guitars = [
        Guitar(name: "Acoustic One", subtitle: "溫暖木質音色・入門首選", price: "NT$ 8,800", imageURL: "https://images.unsplash.com/photo-1510915361894-db8b60106cb1?auto=format&fit=crop&w=1000&q=85", tag: "人氣推薦"),
        Guitar(name: "Studio Electric", subtitle: "俐落外型・清晰音色", price: "NT$ 12,800", imageURL: "https://images.unsplash.com/photo-1564186763535-ebb21ef5277f?auto=format&fit=crop&w=1000&q=85", tag: "新品"),
        Guitar(name: "Travel Mini", subtitle: "輕巧好攜帶・隨時創作", price: "NT$ 5,600", imageURL: "https://images.unsplash.com/photo-1525201548942-d8732f6617a0?auto=format&fit=crop&w=1000&q=85", tag: "輕巧款")
    ]

    var body: some View {
        ZStack {
            Color(red: 0.97, green: 0.96, blue: 0.93).ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 28) {
                    header
                    hero
                    categoryPicker
                    productSection
                    footer
                }
                .padding(.horizontal, 22)
                .padding(.top, 12)
                .padding(.bottom, 28)
                .frame(maxWidth: 900)
                .frame(maxWidth: .infinity)
            }
        }
        .preferredColorScheme(.light)
    }

    private var header: some View {
        HStack {
            HStack(spacing: 9) {
                Image(systemName: "music.note")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(Color(red: 0.55, green: 0.29, blue: 0.17))
                Text("STRUM.")
                    .font(.system(size: 21, weight: .black, design: .rounded))
                    .tracking(2)
                    .foregroundStyle(Color(red: 0.15, green: 0.15, blue: 0.14))
            }
            Spacer()
            Button {
                // Demo cart interaction
            } label: {
                HStack(spacing: 7) {
                    Image(systemName: "bag")
                    Text("購物袋")
                    Text("\(cartCount)")
                        .font(.caption.bold())
                        .padding(.horizontal, 7)
                        .padding(.vertical, 4)
                        .background(Color.white.opacity(0.16), in: Capsule())
                }
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(.white)
                .padding(.horizontal, 13)
                .padding(.vertical, 10)
                .background(Color(red: 0.16, green: 0.17, blue: 0.15), in: Capsule())
            }
            .buttonStyle(.plain)
        }
    }

    private var hero: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1510915361894-db8b60106cb1?auto=format&fit=crop&w=1600&q=90")) { phase in
                if let image = phase.image {
                    image.resizable().scaledToFill()
                } else {
                    LinearGradient(colors: [Color(red: 0.28, green: 0.22, blue: 0.17), Color(red: 0.62, green: 0.42, blue: 0.27)], startPoint: .topLeading, endPoint: .bottomTrailing)
                }
            }
            .frame(height: 390)
            .frame(maxWidth: .infinity)
            .clipped()
            .overlay(Color.black.opacity(0.34))

            VStack(alignment: .leading, spacing: 14) {
                Text("FIND YOUR SOUND")
                    .font(.system(size: 11, weight: .bold))
                    .tracking(3)
                    .foregroundStyle(Color(red: 0.95, green: 0.77, blue: 0.56))
                Text("讓每個\n音符都有故事。")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .lineSpacing(5)
                    .foregroundStyle(.white)
                Text("為日常挑一把好吉他，開始你的音樂旅程。")
                    .font(.system(size: 13))
                    .foregroundStyle(.white.opacity(0.86))
                Button {
                    withAnimation { selectedCategory = "全部" }
                } label: {
                    HStack(spacing: 8) {
                        Text("探索吉他")
                        Image(systemName: "arrow.right")
                    }
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color(red: 0.16, green: 0.17, blue: 0.15))
                    .padding(.horizontal, 18)
                    .padding(.vertical, 12)
                    .background(Color(red: 0.96, green: 0.83, blue: 0.65), in: Capsule())
                }
                .buttonStyle(.plain)
            }
            .padding(26)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }

    private var categoryPicker: some View {
        HStack(spacing: 9) {
            ForEach(categories, id: \.self) { category in
                Button {
                    selectedCategory = category
                } label: {
                    Text(category)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(selectedCategory == category ? .white : Color(red: 0.35, green: 0.34, blue: 0.31))
                        .padding(.horizontal, 17)
                        .padding(.vertical, 10)
                        .background(selectedCategory == category ? Color(red: 0.20, green: 0.21, blue: 0.18) : Color.white, in: Capsule())
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var productSection: some View {
        VStack(alignment: .leading, spacing: 17) {
            HStack(alignment: .lastTextBaseline) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("精選商品")
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                        .foregroundStyle(Color(red: 0.15, green: 0.15, blue: 0.14))
                    Text("挑選一把，陪你寫下自己的旋律。")
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Text("03 ITEMS")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(1.5)
                    .foregroundStyle(.secondary)
            }

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 220), spacing: 15)], spacing: 15) {
                ForEach(guitars) { guitar in
                    productCard(guitar)
                }
            }
        }
    }

    private func productCard(_ guitar: Guitar) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack(alignment: .topLeading) {
                AsyncImage(url: URL(string: guitar.imageURL)) { phase in
                    if let image = phase.image {
                        image.resizable().scaledToFill()
                    } else {
                        Rectangle().fill(Color(red: 0.88, green: 0.85, blue: 0.79))
                            .overlay(Image(systemName: "guitars.fill").font(.system(size: 36)).foregroundStyle(.white.opacity(0.8)))
                    }
                }
                .frame(height: 190)
                .frame(maxWidth: .infinity)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 17, style: .continuous))

                Text(guitar.tag)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundStyle(Color(red: 0.22, green: 0.20, blue: 0.17))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(Color(red: 0.97, green: 0.91, blue: 0.80), in: Capsule())
                    .padding(11)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(guitar.name)
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(red: 0.15, green: 0.15, blue: 0.14))
                Text(guitar.subtitle)
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
                HStack {
                    Text(guitar.price)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(Color(red: 0.48, green: 0.27, blue: 0.17))
                    Spacer()
                    Button {
                        cartCount += 1
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 34, height: 34)
                            .background(Color(red: 0.20, green: 0.21, blue: 0.18), in: Circle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("將\(guitar.name)加入購物袋")
                }
                .padding(.top, 5)
            }
            .padding(.horizontal, 3)
            .padding(.bottom, 3)
        }
        .padding(12)
        .background(.white, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
    }

    private var footer: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text("STRUM.")
                    .font(.system(size: 15, weight: .black, design: .rounded))
                    .tracking(2)
                Text("Good guitars. Good days.")
                    .font(.system(size: 11))
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "heart.fill")
                .foregroundStyle(Color(red: 0.65, green: 0.35, blue: 0.23))
            Text("Made for music lovers")
                .font(.system(size: 11))
                .foregroundStyle(.secondary)
        }
        .padding(.top, 8)
    }
}

#Preview {
    ContentView()
}

import SwiftUI

struct GenreTag: View {
    let genre: Genre
    var style: TagStyle
    var size: TagSize
    let onTap: ((Int) -> Void)?
    
    init(genre: Genre, style: TagStyle, size: TagSize, onTap: ((Int) -> Void)? = nil) {
        self.genre = genre
        self.style = style
        self.size = size
        self.onTap = onTap
    }
    
    var body: some View {
        Text(genre.name)
            .font(size.font)
            .lineLimit(1)
            .foregroundStyle(style.textColor)
            .fontWeight(style.fontWeight)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(style.backgroundColor)
                    .stroke(style.strokeColor, lineWidth: 1)
            )
            .onTapGesture {
                onTap?(genre.id)
            }
            .padding([.vertical, .trailing], 6)
    }
}

#Preview {
    ForEach(TagSize.allCases, id: \.self) { size in
        ForEach(TagStyle.allCases, id: \.self) { style in
            GenreTag(genre: .init(id: 1, name: "Action"), style: style, size: size)
        }
    }
}

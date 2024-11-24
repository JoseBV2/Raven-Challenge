
struct ArticleCardView: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageURL = article.imageURL {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .cornerRadius(10)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(height: 200)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                }
            }
            
            Text(article.title)
                .font(.headline)
                .lineLimit(2)
            
            HStack {
                Text(article.byline)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Text(article.publishedDate)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
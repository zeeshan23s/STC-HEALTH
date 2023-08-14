import '../exports.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: ScreenHelper.screenHeight(context) * 0.1,
              width: ScreenHelper.screenWidth(context),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFFDFDFD),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6B7F99).withOpacity(0.25),
                    offset: const Offset(0, 1),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(ScreenHelper.screenWidth(context) * 0.08),
                  bottomRight:
                      Radius.circular(ScreenHelper.screenWidth(context) * 0.08),
                ),
              ),
              child: Text(
                'All Products',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Flexible(
              child: FutureBuilder<List<Product>>(
                future: ProductController.getProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData) {
                    return const Center(
                      child: Text('No data available'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              product: snapshot.data![index],
                            ),
                          ),
                        ),
                        child: productListContainer(
                          context: context,
                          imageURL: snapshot.data![index].image,
                          title: snapshot.data![index].title,
                          description: snapshot.data![index].description ?? '',
                          price: '${snapshot.data![index].price} AED',
                          rating: snapshot.data![index].rating.rate,
                        ),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget productListContainer(
      {required BuildContext context,
      required String imageURL,
      required String title,
      required String description,
      required String price,
      required double rating}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: ScreenHelper.screenHeight(context) * 0.02,
          horizontal: ScreenHelper.screenWidth(context) * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: ScreenHelper.screenHeight(context) * 0.30,
            width: ScreenHelper.screenWidth(context) * 0.9,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imageURL), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(
                    ScreenHelper.screenHeight(context) * 0.025)),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenHelper.screenHeight(context) * 0.02,
                    horizontal: ScreenHelper.screenWidth(context) * 0.04),
                color: Colors.black.withOpacity(0.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(price,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w700)),
                    Row(
                      children: List.generate(
                        5,
                        (index) {
                          if (index + 1 <= rating.floor()) {
                            return const Icon(
                              Icons.star,
                              color: Colors.amber,
                            );
                          } else if (rating.floor() < index + 1 &&
                              rating.ceil() == index + 1) {
                            return const Icon(
                              Icons.star_half,
                              color: Colors.amber,
                            );
                          } else {
                            return const Icon(
                              Icons.star_border,
                              color: Colors.amber,
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: ScreenHelper.screenHeight(context) * 0.01),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: ScreenHelper.screenHeight(context) * 0.005),
          SizedBox(
            height: ScreenHelper.screenHeight(context) * 0.04,
            child: Text(
              description,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.w400),
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}

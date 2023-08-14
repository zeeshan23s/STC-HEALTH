import '../exports.dart';

class DetailScreen extends StatefulWidget {
  final Product product;
  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _ratingVisible = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Container(
            height: _ratingVisible
                ? ScreenHelper.screenHeight(context) * 0.60
                : ScreenHelper.screenHeight(context) * 0.75,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.product.image), fit: BoxFit.cover),
            ),
            child: SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: ScreenHelper.screenHeight(context) * 0.02,
                  horizontal: ScreenHelper.screenWidth(context) * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                ],
              ),
            )),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: _ratingVisible
                ? ScreenHelper.screenHeight(context) * 0.45
                : ScreenHelper.screenHeight(context) * 0.3,
            width: ScreenHelper.screenWidth(context),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                  ScreenHelper.screenHeight(context) * 0.05),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenHelper.screenWidth(context) * 0.04),
              child: Column(
                children: [
                  IconButton(
                    onPressed: () => setState(() {
                      _ratingVisible = !_ratingVisible;
                    }),
                    icon: Icon(
                        _ratingVisible
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.primaryColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.ios_share,
                              color: AppColors.primaryColor),
                        ),
                      ),
                      CustomButton(
                          onTab: () {},
                          label: 'Order Now',
                          height: ScreenHelper.screenHeight(context) * 0.08,
                          width: ScreenHelper.screenWidth(context) * 0.7)
                    ],
                  ),
                  SizedBox(height: ScreenHelper.screenHeight(context) * 0.02),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Description',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  SizedBox(height: ScreenHelper.screenHeight(context) * 0.01),
                  SizedBox(
                    height: _ratingVisible
                        ? ScreenHelper.screenHeight(context) * 0.13
                        : ScreenHelper.screenHeight(context) * 0.09,
                    child: Text(
                      widget.product.description ?? '',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(
                      height: _ratingVisible
                          ? ScreenHelper.screenHeight(context) * 0.01
                          : 0),
                  _ratingVisible
                      ? Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    ScreenHelper.screenWidth(context) * 0.02),
                            child: SizedBox(
                              height: ScreenHelper.screenHeight(context) * 0.1,
                              width: ScreenHelper.screenWidth(context) * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Reviews (${widget.product.rating.count})',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            ScreenHelper.screenWidth(context) *
                                                0.02),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          widget.product.rating.rate.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                            height: ScreenHelper.screenHeight(
                                                    context) *
                                                0.05),
                                        Row(
                                          children: List.generate(
                                            5,
                                            (index) {
                                              if (index + 1 <=
                                                  widget.product.rating.rate
                                                      .floor()) {
                                                return const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                );
                                              } else if (widget
                                                          .product.rating.rate
                                                          .floor() <
                                                      index + 1 &&
                                                  widget.product.rating.rate
                                                          .ceil() ==
                                                      index + 1) {
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
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

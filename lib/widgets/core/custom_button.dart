import '../../exports.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTab;
  final String label;
  final double height;
  final double width;
  const CustomButton(
      {super.key,
      required this.onTab,
      required this.label,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTab(),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius:
              BorderRadius.circular(ScreenHelper.screenHeight(context) * 0.05),
        ),
        child: Center(
          child: Text(label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}

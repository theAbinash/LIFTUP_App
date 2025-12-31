import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liftup/feature/workout/domain/entities/bottom_sheet_menu.dart';

class CustomBottomsheet extends StatelessWidget  {
  final String title;
  final List<BottomSheetMenu> items;
  final double initialHeight;
  final double minHeight;
  final double maxHeight;

  const CustomBottomsheet({
    super.key,
    required this.title,
    required this.items,
    this.initialHeight = 0.8,
    this.minHeight = 0.4,
    this.maxHeight = 0.95,
  });

  @override
  Widget build(BuildContext context) {

    final sheetBg = const Color(0xFF1C1C1E); // outer darker
    final itemBg = const Color(0xFF2C2C2E);  // inner lighter

    final media = MediaQuery.of(context);
    final screenHeight = media.size.height;
    final isLandscape = media.orientation == Orientation.landscape;

    final adjustedInitialHeight = isLandscape
        ? 0.7
        : screenHeight < 700
            ? 0.9
            : initialHeight;
    final adjustedMinHeight = isLandscape ? 0.3 : minHeight;
    final adjustedMaxHeight = isLandscape ? 0.9 : maxHeight;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: adjustedInitialHeight,
      minChildSize: adjustedMinHeight,
      maxChildSize: adjustedMaxHeight,
      builder: (context, scrollController) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: sheetBg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SafeArea(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 55.w,
                height: 5.h,
                margin: EdgeInsets.only(top: 10.h, bottom: 8.h),
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              SizedBox(height: 6.h,),

              //Custom Header
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                ),
              SizedBox(height: 6.h,),
              Divider(height: 1.h, color: Colors.grey),

              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final action = items[index];
                    final isFirst = index == 0;
                    final isLast = index == items.length - 1;

                    return Container(
                      margin: EdgeInsets.only(bottom: 1.h),
                      decoration: BoxDecoration(
                        color: itemBg,
                        borderRadius: BorderRadius.vertical(
                          top: isFirst ? Radius.circular(12.r) : Radius.zero,
                          bottom: isLast ? Radius.circular(12.r) : Radius.zero,
                        ),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.vertical(
                          top: isFirst ? Radius.circular(12.r) : Radius.zero,
                          bottom: isLast ? Radius.circular(12.r) : Radius.zero,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          action.onTap();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
                          child: Row(
                            children: [
                              Icon(action.icon, color: action.color, size: 24.sp,),
                              SizedBox(width: 18.w,),
                              Expanded(
                                child: Text(
                                    action.label,
                                    style: TextStyle(
                                      color: action.color,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ) 
                            ],
                          ),
                          ),
                    ),
                    );
                  },
                  
                ),
              ),
              SizedBox(height: 8.h),
            ],
          ),
          )
        );
      }
      );
  }
}
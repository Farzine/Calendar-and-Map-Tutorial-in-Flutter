// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Button extends StatelessWidget {
//   final String text;
//   final String routeName;
//   final VoidCallback? onPressed;
//   final IconData? icon;
//   final bool isLoading;
//   final Color textColor;
//   final Color backgroundColor;
  
//   const Button({
//     super.key,
//     required this.text,
//     required this.routeName,
//     this.onPressed,
//     this.icon,
//     this.isLoading = false,
//     this.textColor = const Color.fromRGBO(255, 255, 255, 1), 
//     this.backgroundColor = const Color.fromRGBO(255, 68, 5, 1),
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Fixed properties 
//     const double buttonWidth = 328;
//     const double buttonHeight = 48;
//     const double cornerRadius = 8;
//     const EdgeInsets buttonPadding = EdgeInsets.fromLTRB(126, 10, 126, 10); //EdgeInsets.symmetric(horizontal: 16.0, vertical: 10)
//     const double gap = 10;
//     const double textWidth = 76;
//     const double textHeight = 18;
//     const double textMaxWidth = 300;
    
//     return Container(
//       constraints: const BoxConstraints(
//         maxWidth: buttonWidth, // Hug width (328px)
//       ),
//       height: buttonHeight, // Fixed height (48px)
//       child: ElevatedButton(
//         onPressed: isLoading ? null : () {
//           // Execute callback if provided
//           if (onPressed != null) {
//             onPressed!();
//           }
          
//           // Navigate with instant animation
//           Navigator.of(context).pushNamed(
//             routeName,
//             arguments: null,
//           );
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: backgroundColor, 
//           foregroundColor: textColor, 
//           padding: buttonPadding, 
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(cornerRadius), 
//           ),
//           elevation: 0, // No shadow
//           disabledBackgroundColor: backgroundColor,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // loading indicator
//             if (isLoading) ...[
//               SizedBox(
//                 width: 14,
//                 height: 14,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                   valueColor: AlwaysStoppedAnimation<Color>(textColor),
//                 ),
//               ),
//               const SizedBox(width: gap / 2), 
//             ] 
//             // Show icon if provided and not loading
//             else if (icon != null) ...[
//               Icon(
//                 icon,
//                 size: 18,
//                 color: textColor,
//               ),
//               const SizedBox(width: gap / 2), 
//             ],
            
//             Container(
//               width: textWidth, // Fixed width (76px)
//               height: textHeight, // Fixed height (18px)
//               constraints: const BoxConstraints(
//                 maxWidth: textMaxWidth, // Max width constraint (300px)
//               ),
//               alignment: Alignment.center, // vertical middle alignment
//               child: Text(
//                 text,
//                 style: GoogleFonts.urbanist(
//                   fontWeight: FontWeight.w700, // Fixed weight (700)
//                   fontSize: 14, // Fixed size (14px)
//                   height: textHeight / 14, // Fixed line height (18px)
//                   letterSpacing: 0, // Fixed letter spacing (0px)
//                   color: textColor, 
//                 ),
//                 textAlign: TextAlign.center, // horizontal alignment (Center)
//                 overflow: TextOverflow.ellipsis, // Handle text overflow gracefully
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final String text;
  final String routeName;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final Color textColor;
  final Color backgroundColor;
  
  const Button({
    super.key,
    required this.text,
    required this.routeName,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.textColor = const Color.fromRGBO(255, 255, 255, 1), 
    this.backgroundColor = const Color.fromRGBO(255, 68, 5, 1),
  });

  @override
  Widget build(BuildContext context) {
    // Fixed properties 
    const double buttonWidth = 328;
    const double buttonHeight = 48;
    const double cornerRadius = 8;
    const EdgeInsets buttonPadding = EdgeInsets.symmetric(vertical: 10);
    const double textHeight = 18;
    const double textMaxWidth = 300;
    
    // Small gap between icon and text
    const double iconTextGap = 10;
    
    return Container(
      constraints: const BoxConstraints(
        maxWidth: buttonWidth, // Hug width (328px)
      ),
      height: buttonHeight, // Fixed height (48px)
      child: ElevatedButton(
        onPressed: isLoading ? null : () {
          // Execute callback if provided
          if (onPressed != null) {
            onPressed!();
          }
          
          // Navigate with instant animation
          Navigator.of(context).pushNamed(
            routeName,
            arguments: null,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, 
          foregroundColor: textColor,
          padding: buttonPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius), 
          ),
          elevation: 0, // No shadow
          disabledBackgroundColor: backgroundColor,
        ),
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: iconTextGap,
            children: [
              // Loading indicator or icon
              if (isLoading)
                SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
                )
              else if (icon != null)
                Icon(
                  icon,
                  size: 18,
                  color: textColor,
                ),
                
              // Text with dynamic width
              Container(
                constraints: const BoxConstraints(
                  maxWidth: textMaxWidth,
                ),
                height: textHeight,
                child: Text(
                  text,
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: textHeight / 14,
                    letterSpacing: 0,
                    color: textColor,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
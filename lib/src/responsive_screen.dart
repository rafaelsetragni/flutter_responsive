import 'responsive_enum.dart';

/// Contains all screen size limits and all functions to test those limits
class ResponsiveScreen {
  /// Screen width size limits
  static Map<ScreenSize, double> limits = {
    ScreenSize.us: 0.00,
    // Smart watches
    ScreenSize.xs: 310.00,
    // Small phones (5S)
    ScreenSize.sm: 576.00,
    // Medium phones
    ScreenSize.md: 768.00,
    // Large phones (iPhone X)
    ScreenSize.lg: 992.00,
    // Tablets
    ScreenSize.xl: 1200.00,
    // Laptops
    ScreenSize.ul: 2000.00,
    // Desktops and TVs 4K
  };

  /// Gets the latest screen limit which contains width size
  static getReferenceSize(double width) {
    ScreenSize located = limits.keys.first;
    for (ScreenSize tag in limits.keys) {
      if (limits[tag] > width) return located;
      located = tag;
    }
    return located;
  }

  /// Test if screen size limit respects the limit width referenced by tag
  static bool isScreenSize(ScreenSize tag, double screenSize) {
    return !limits.containsKey(tag)
        ? false
        : (screenSize < 0 ? 0 : screenSize) >= limits[tag];
  }
}

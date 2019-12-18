
/// Contains all screen size limits and all functions to test those limits
class ResponsiveScreen {

  /// Screen width size limits
  static Map<String, double> limits = {
    'us': 0.00,
    // Smart watches
    'xs': 310.00,
    // Small phones (5S)
    'sm': 576.00,
    // Medium phones
    'md': 768.00,
    // Large phones (iPhone X)
    'lg': 992.00,
    // Tablets
    'xl': 1200.00,
    // Laptops
    'ul': 2000.00,
    // Desktops and TVs 4K
  };

  /// Gets the latest screen limit which contains width size
  static getReferenceSize(double width) {
    String located = limits.keys.first;
    for (String tag in limits.keys) {
      if (limits[tag] > width) return located;
      located = tag;
    }
    return located;
  }

  /// Test if screen size limit respects the limit width referenced by tag
  static bool isScreenSize(String tag, double screenSize) {
    return !limits.containsKey(tag)
        ? false
        : (screenSize < 0 ? 0 : screenSize) >= limits[tag];
  }
}

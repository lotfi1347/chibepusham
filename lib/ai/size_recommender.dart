class SizeRecommender {
  static String suggest(double shoulderWidth) {
    if (shoulderWidth < 180) return "S";
    if (shoulderWidth < 220) return "M";
    if (shoulderWidth < 260) return "L";
    return "XL";
  }
}
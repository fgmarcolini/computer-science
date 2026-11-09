// represent information about an image
class Image {

  int width; // in pixels
  int height; // in pixels
  String source;

  Image(int width, int height, String source) {
    this.width = width;
    this.height = height;
    this.source = source;
  }

  // produce "small", "medium" or "large" depending on the number of pixel in this image.
  String sizeString() {
    int pixels = this.area();
    if (pixels <= 10000) {
      return "small";
    } else if (pixels <= 1000000) {
      return "medium";
    } else {
      return "large";
    }
  }

  private int area() {
    return this.height * this.width;
  }
}

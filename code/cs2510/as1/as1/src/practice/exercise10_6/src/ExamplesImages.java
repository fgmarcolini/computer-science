import tester.Tester;

/*
 * Exercise 10.6 Take a look at this following class:
 * Design the method sizeString for this class. It produces one of three strings,
 * depending on the number of pixels in the image:
 * 1. "small" for images with 10,000 pixels or fewer;
 * 2. "medium" for images with between 10,001 and 1,000,000 pixels;
 * 3. "large" for images that are even larger than that.
 * Remember that the number of pixels in an image is determined by the area
 * of the image.
 */
public class ExamplesImages {
  Image i1 = new Image(2, 2, "a");
  Image i2 = new Image(100, 100, "b");
  Image i3 = new Image(120, 120, "c");
  Image i4 = new Image(1000, 1000, "d");
  Image i5 = new Image(1005, 1005, "e");

  boolean testSizeString(Tester t) {
    return
        t.checkExpect(i1.sizeString(), "small") &&
            t.checkExpect(i2.sizeString(), "small") &&
            t.checkExpect(i3.sizeString(), "medium") &&
            t.checkExpect(i4.sizeString(), "medium") &&
            t.checkExpect(i5.sizeString(), "large");
  }
}

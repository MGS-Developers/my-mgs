int getGridViewCrossCount(double screenWidth) {
  if (screenWidth > 1024) {
    return 5;
  } else if (screenWidth > 768) {
    return 4;
  } else if (screenWidth > 500) {
    return 3;
  } else {
    return 2;
  }
}

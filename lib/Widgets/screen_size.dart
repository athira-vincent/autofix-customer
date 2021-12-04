class ScreenSize {
  ScreenSize();
  double setValue(double value) {
    return value * per + value;
  }

  double per = .10;
  double perfont = .10;
  double setValueFont(double value) {
    return value * perfont + value;
  }
}

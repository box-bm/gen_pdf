double getSecure(double total) {
  if (total == 0) return 0;

  return ((total * 1.65) / 100) + 20;
}

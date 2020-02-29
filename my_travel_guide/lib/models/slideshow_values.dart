String getPlaceURL(String placeName) {
  if (placeName == 'Pyramids of Giza') {
    return 'assets/images/pyramids.jpg';
  } else if (placeName == 'Jerusalem') {
    return 'assets/images/jerusalem.jpg';
  } else if (placeName == 'Petra') {
    return 'assets/images/petra.jpg';
  } else if (placeName == 'Rome') {
    return 'assets/images/trevi.jpg';
  }
}

List<double> getPlaceLatLng(String placeName) {
  if (placeName == 'Pyramids of Giza') {
    List<double> list = [30.0131, 31.2089];
    return list;
  } else if (placeName == 'Jerusalem') {
    List<double> list = [31.7683, 35.2137];
    return list;
  } else if (placeName == 'Petra') {
    List<double> list = [30.3285,  35.4444];
    return list;
  } else if (placeName == 'Rome') {
    List<double> list = [41.9028, 12.4964];
    return list;
  }
}

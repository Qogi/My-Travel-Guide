final List<String> imgList = [
  'https://images.unsplash.com/photo-1539650116574-8efeb43e2750?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjgzMjIyfQ',
  'https://images.unsplash.com/photo-1542743408-218cc173cda0?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjgzMjIyfQ',
  'https://images.unsplash.com/photo-1501232060322-aa87215ab531?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjgzMjIyfQ',
  'https://images.unsplash.com/photo-1503970999490-4404449dc349?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjgzMjIyfQ'
];

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

import 'package:flutter/material.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/utils/images.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

final List<Map<String, dynamic>> demoData = [
  {
    'book' : 'The Power of Positive Thinking',
    'writer' : 'Arundhati Roy Benerji',
    'author' : 'Naomi David Alderman',
    'parts' : '115',
    'views' : '86k',
    'bookCover' : "https://www.adobe.com/express/create/cover/media_178ebed46ae02d6f3284c7886e9b28c5bb9046a02.jpeg"
  },
  {
    'book' : 'The Power',
    'writer' : 'Arundhati Roykia',
    'author' : 'Naomi Alderman',
    'parts' : '30',
    'views' : '960',
    'bookCover' : "https://www.adobe.com/express/create/cover/media_178ebed46ae02d6f3284c7886e9b28c5bb9046a02.jpeg"
  },
  {
    'book' : 'The Power',
    'writer' : 'Arundhati Roy',
    'author' : 'Naomi Alderman',
    'parts' : '115',
    'views' : '1.2k',
    'bookCover' : "https://www.adobe.com/express/create/cover/media_178ebed46ae02d6f3284c7886e9b28c5bb9046a02.jpeg"
  },
  {
    'book' : 'The Power',
    'writer' : 'Arundhati Roy',
    'author' : 'Naomi Alderman',
    'parts' : '51',
    'views' : '86',
    'bookCover' : "https://www.adobe.com/express/create/cover/media_178ebed46ae02d6f3284c7886e9b28c5bb9046a02.jpeg"
  },
  {
    'book' : 'The Power',
    'writer' : 'Arundhati Roy',
    'author' : 'Naomi Alderman',
    'parts' : '115',
    'views' : '86',
    'bookCover' : "https://www.adobe.com/express/create/cover/media_178ebed46ae02d6f3284c7886e9b28c5bb9046a02.jpeg"
  },
  {
    'book' : 'The Power of Positive Thinking',
    'writer' : 'Arundhati Roy Benerji',
    'author' : 'Naomi David Alderman',
    'parts' : '115',
    'views' : '86k',
    'bookCover' : "https://www.adobe.com/express/create/cover/media_178ebed46ae02d6f3284c7886e9b28c5bb9046a02.jpeg"
  },
  {
    'book' : 'The Power',
    'writer' : 'Arundhati Roykia',
    'author' : 'Naomi Alderman',
    'parts' : '30',
    'views' : '960',
    'bookCover' : "https://www.adobe.com/express/create/cover/media_178ebed46ae02d6f3284c7886e9b28c5bb9046a02.jpeg"
  },
  {
    'book' : 'The Power',
    'writer' : 'Arundhati Roy',
    'author' : 'Naomi Alderman',
    'parts' : '115',
    'views' : '1.2k',
    'bookCover' : "https://www.adobe.com/express/create/cover/media_178ebed46ae02d6f3284c7886e9b28c5bb9046a02.jpeg"
  },
  {
    'book' : 'The Power',
    'writer' : 'Arundhati Roy',
    'author' : 'Naomi Alderman',
    'parts' : '51',
    'views' : '86',
    'bookCover' : "https://www.adobe.com/express/create/cover/media_178ebed46ae02d6f3284c7886e9b28c5bb9046a02.jpeg"
  },
  {
    'book' : 'The Power',
    'writer' : 'Arundhati Roy',
    'author' : 'Naomi Alderman',
    'parts' : '115',
    'views' : '86',
    'bookCover' : "https://www.adobe.com/express/create/cover/media_178ebed46ae02d6f3284c7886e9b28c5bb9046a02.jpeg"
  }
];

final List<Map<String, dynamic>> categoryDemoData = [
  {
    'category' : 'Novel',
    'imgUrl' : categoryBook1
  },
  {
    'category' : 'Dairy',
    'imgUrl' : categoryBook1
  },
  {
    'category' : 'Story',
    'imgUrl' : categoryBook1
  },
  {
    'category' : 'Poem',
    'imgUrl' : categoryBook1
  },
  {
    'category' : 'Novel',
    'imgUrl' : categoryBook1
  },
  {
    'category' : 'Dairy',
    'imgUrl' : categoryBook1
  },
  {
    'category' : 'Story',
    'imgUrl' : categoryBook1
  },
  {
    'category' : 'Poem',
    'imgUrl' : categoryBook1
  },
  {
    'category' : 'Novel',
    'imgUrl' : categoryBook1
  },
  {
    'category' : 'Dairy',
    'imgUrl' : categoryBook1
  },
  {
    'category' : 'Story',
    'imgUrl' : categoryBook1
  },
  {
    'category' : 'Poem',
    'imgUrl' : categoryBook1
  },
  {
    'category' : 'Novel',
    'imgUrl' : categoryBook1
  },
  {
    'category' : 'Dairy',
    'imgUrl' : categoryBook1
  },
  {
    'category' : 'Story',
    'imgUrl' : categoryBook1
  },
  {
    'category' : 'Poem',
    'imgUrl' : categoryBook1
  },

];

final List<String> subCategoryDemoData = [
  'All',
  'Horror',
  'Fantasy',
  'Adventure',
  'Humor',
  'Mystery',
  'Adult',
  'Thriller',
  'Poetry',
  'Teen Fiction',
  'Short Stroy'
];

final List<Map<String, dynamic>> dashboardDemoData = [
  {
    'info' : 'Total Points',
    'numbers' : '99',
    'icons' : Icons.currency_exchange
  },
  {
    'info' : 'Posts',
    'numbers' : '20',
    'icons' : Icons.my_library_books_outlined
  },
  {
    'info' : 'Following',
    'numbers' : '23k',
    'icons' : Icons.person_add_alt_1_outlined
  },
  {
    'info' : 'Followers',
    'numbers' : '23k',
    'icons' : Icons.people_alt_outlined
  },
  {
    'info' : 'Trophy',
    'numbers' : '4',
    'icons' : Icons.wine_bar_rounded
  },
  {
    'info' : 'Total Rank',
    'numbers' : '58',
    'icons' : Icons.leaderboard_outlined
  },

];

final List<Map<String, dynamic>> lekhnyTrophyDemoData = [
  {
    'level' : 'Lekhny Sadasay',
    'getTrophies' : '50+ Posts, 500+ Likes, 50+ Followers',
    'trophy' : '151-300 Trophy',
    'color' : member,

  },
  {
    'level' : 'Lekhny Kansayrath',
    'getTrophies' : '50+ Posts, 500+ Likes, 50+ Followers',
    'trophy' : '151-300 Trophy',
    'color' : bronze,
      },
  {
    'level' : 'Lekhny Rajatrath',
    'getTrophies' : '50+ Posts, 500+ Likes, 50+ Followers',
    'trophy' : '151-300 Trophy',
    'color' : colorLight3,
      },
  {
    'level' : 'Lekhny Svarnrath',
    'getTrophies' : '50+ Posts, 500+ Likes, 50+ Followers',
    'trophy' : '151-300 Trophy',
    'color' : secondaryColorLight,
      },
  {
    'level' : 'Lekhny Hirrath',
    'getTrophies' : '50+ Posts, 500+ Likes, 50+ Followers',
    'trophy' : '151-300 Trophy',
    'color' : diamond,
      },
  {
    'level' : 'Lekhny Stambh',
    'getTrophies' : '50+ Posts, 500+ Likes, 50+ Followers',
    'trophy' : '151-300 Trophy',
    'color' : primaryColor,
      },

];



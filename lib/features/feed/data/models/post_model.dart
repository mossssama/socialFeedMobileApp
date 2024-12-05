import 'package:social_feed/features/feed/domain/entities/feeds_entity.dart';

class FeedsModel {
  List<Posts>? posts;

  FeedsModel({this.posts});

  FeedsModel.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Posts {
  String? id;
  From? from;
  String? message;
  String? picture;
  String? link;
  String? name;
  String? caption;
  String? description;
  String? createdTime;
  String? updatedTime;
  Shares? shares;
  Reactions? reactions;
  Reactions? comments;

  Posts({this.id, this.from, this.message, this.picture, this.link, this.name, this.caption, this.description, this.createdTime, this.updatedTime, this.shares, this.reactions, this.comments});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'] != null ? From.fromJson(json['from']) : null;
    message = json['message'];
    picture = json['picture'];
    link = json['link'];
    name = json['name'];
    caption = json['caption'];
    description = json['description'];
    createdTime = json['created_time'];
    updatedTime = json['updated_time'];
    shares = json['shares'] != null ? Shares.fromJson(json['shares']) : null;
    reactions = json['reactions'] != null ? Reactions.fromJson(json['reactions']) : null;
    comments = json['comments'] != null ? Reactions.fromJson(json['comments']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (from != null) {
      data['from'] = from!.toJson();
    }
    data['message'] = message;
    data['picture'] = picture;
    data['link'] = link;
    data['name'] = name;
    data['caption'] = caption;
    data['description'] = description;
    data['created_time'] = createdTime;
    data['updated_time'] = updatedTime;
    if (shares != null) {
      data['shares'] = shares!.toJson();
    }
    if (reactions != null) {
      data['reactions'] = reactions!.toJson();
    }
    if (comments != null) {
      data['comments'] = comments!.toJson();
    }
    return data;
  }
}

class From {
  String? name;
  String? id;

  From({this.name, this.id});

  From.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

class Shares {
  int? count;

  Shares({this.count});

  Shares.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    return data;
  }
}

class Reactions {
  List<Data>? data;
  Paging? paging;
  Summary? summary;

  Reactions({this.data, this.paging, this.summary});

  Reactions.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
    summary = json['summary'] != null ? Summary.fromJson(json['summary']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (paging != null) {
      data['paging'] = paging!.toJson();
    }
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? type;
  From? from;
  String? message;
  String? createdTime;
  int? likeCount;

  Data({this.id, this.name, this.type, this.from, this.message, this.createdTime, this.likeCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    from = json['from'] != null ? From.fromJson(json['from']) : null;
    message = json['message'];
    createdTime = json['created_time'];
    likeCount = json['like_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    if (from != null) {
      data['from'] = from!.toJson();
    }
    data['message'] = message;
    data['created_time'] = createdTime;
    data['like_count'] = likeCount;
    return data;
  }
}

class Paging {
  Cursors? cursors;

  Paging({this.cursors});

  Paging.fromJson(Map<String, dynamic> json) {
    cursors = json['cursors'] != null ? Cursors.fromJson(json['cursors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cursors != null) {
      data['cursors'] = cursors!.toJson();
    }
    return data;
  }
}

class Cursors {
  String? before;
  String? after;

  Cursors({this.before, this.after});

  Cursors.fromJson(Map<String, dynamic> json) {
    before = json['before'];
    after = json['after'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['before'] = before;
    data['after'] = after;
    return data;
  }
}

class Summary {
  int? totalCount;

  Summary({this.totalCount});

  Summary.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_count'] = totalCount;
    return data;
  }
}

extension FeedsModelToEntityMapper on FeedsModel {
  FeedsEntity toEntity() {
    List<Feed> feeds = [];
    late Feed tempFeed;
    for (int postIndex = 0; postIndex < posts!.length; postIndex++) {
      tempFeed = Feed(
          postOwnerName: posts![postIndex].from!.name!,
          postOwnerImageUrl: posts![postIndex].picture!, // to be added to json
          postDuration: formatDateTime(posts![postIndex].createdTime!),
          postTextContent: posts![postIndex].message,
          postImageContentUrl: posts![postIndex].picture,
          numberOfReactions: posts![postIndex].reactions!.summary!.totalCount!,
          numberOfShares: posts![postIndex].shares!.count!,
          isReacted: false); // to be added to json
      feeds.add(tempFeed);
    }

    return FeedsEntity(feeds: feeds);
  }
}

String formatDateTime(String dateTimeStr) {
  DateTime dateTime = DateTime.parse(dateTimeStr);

  // Extract components
  int year = dateTime.year;
  int month = dateTime.month;
  int day = dateTime.day;
  int hour = dateTime.hour;
  int minute = dateTime.minute;
  int second = dateTime.second;

  // Format manually
  String formattedDate = "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')} "
      "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')} UTC";

  return formattedDate;
}

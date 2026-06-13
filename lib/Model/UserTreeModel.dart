class UserTreeModel {

  final UserDetail userDetail;

  final List<TreeMember> treeMembers;

  UserTreeModel({

    required this.userDetail,
    required this.treeMembers,
  });

  factory UserTreeModel.fromJson(
      Map<String, dynamic> json) {

    return UserTreeModel(

      userDetail:
      UserDetail.fromJson(
        json['userdetail'],
      ),

      treeMembers:
      (json['treeMembers'] as List)

          .map(
            (e) =>
            TreeMember.fromJson(e),
      )

          .toList(),
    );
  }
}

class UserDetail {

  final String selfId;
  final String fullName;
  final String profilePic;
  final bool isActive;

  UserDetail({

    required this.selfId,
    required this.fullName,
    required this.profilePic,
    required this.isActive,
  });

  factory UserDetail.fromJson(
      Map<String, dynamic> json) {

    return UserDetail(

      selfId:
      json['Self_Id'] ?? '',

      fullName:
      json['FullName'] ?? '',

      profilePic:
      json['ProfilePic'] ?? '',

      isActive:
      json['IsActive'] ?? false,
    );
  }
}

class TreeMember {

  final String selfId;
  final String fullName;
  final String profilePic;
  final bool isActive;

  TreeMember({

    required this.selfId,
    required this.fullName,
    required this.profilePic,
    required this.isActive,
  });

  factory TreeMember.fromJson(
      Map<String, dynamic> json) {

    return TreeMember(

      selfId:
      json['Self_Id'] ?? '',

      fullName:
      json['FullName'] ?? '',

      profilePic:
      json['ProfilePic'] ?? '',

      isActive:
      json['IsActive'] ?? false,
    );
  }
}
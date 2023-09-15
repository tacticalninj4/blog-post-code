import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({Key? key});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final List<Comment> comments = [
    Comment(
      userName: "Jhanarthananraja",
      imageURL:
          "https://api.dicebear.com/7.x/big-smile/svg?seed=Jhanarthananraja",
      content:
          "This is a test comments! This is a test comments! This is a test comments! This is a test comments!",
      type: "text",
      id: "msg-001",
      replies: [
        Reply(
          userName: "John Doe",
          imageURL: "https://api.dicebear.com/7.x/big-smile/svg?seed=JohnDoe",
          content: "https://media.giphy.com/media/TmOpUpxHEtW7ZtdvUc/giphy.gif",
          type: "gif",
          id: "msg-002",
        ),
        Reply(
          userName: "Mary Jane",
          imageURL: "https://api.dicebear.com/7.x/big-smile/svg?seed=MaryJane",
          content: "This is a test reply",
          type: "text",
          id: "msg-003",
        ),
      ],
    ),
    Comment(
      userName: "John Doe",
      imageURL: "https://api.dicebear.com/7.x/big-smile/svg?seed=johndoe",
      content:
          "https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg",
      type: "gif",
      id: "msg-001",
    ),
    Comment(
      userName: "Jhanarthananraja",
      imageURL:
          "https://api.dicebear.com/7.x/big-smile/svg?seed=Jhanarthananraja",
      content: "https://media.giphy.com/media/TmOpUpxHEtW7ZtdvUc/giphy.gif",
      type: "gif",
      id: "msg-001",
      replies: [
        Reply(
          userName: "Jhanarthananraja",
          imageURL:
              "https://api.dicebear.com/7.x/big-smile/svg?seed=Jhanarthananraja",
          content:
              "This is a test comments! This is a test comments! This is a test comments! This is a test comments!",
          type: "text",
          id: "msg-001",
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Comment Section",
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.grey[100],
        padding: EdgeInsets.all(8),
        child: ListView(
          shrinkWrap: true,
          children:
              comments.map((comment) => CommentItem(comment: comment)).toList(),
        ),
      ),
    );
  }
}

class CommentItem extends StatefulWidget {
  final Comment comment;
  const CommentItem({Key? key, required this.comment});

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool showReply = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ParentComment(comment: widget.comment),
          if (!showReply)
            if (widget.comment.replies.isNotEmpty)
              TextButton(
                onPressed: () {
                  setState(() {
                    showReply = true;
                  });
                },
                child: Text("Show ${widget.comment.replies.length} Replies"),
              ),
          if (showReply)
            ...widget.comment.replies.map((reply) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                      Expanded(
                        child: ReplyComment(reply: reply),
                        flex: 8,
                      ),
                    ],
                  ),
                ],
              );
            }).toList(),
          Divider(),
        ],
      ),
    );
  }
}

class ParentComment extends StatelessWidget {
  final Comment comment;

  ParentComment({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: CircleAvatar(
            child: SvgPicture.network(
              comment.imageURL,
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: ListTile(
            trailing: IconButton(
                onPressed: () {}, icon: Icon(Icons.favorite_border_rounded)),
            dense: true,
            title: Text(
              comment.userName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: comment.type == "text"
                ? Text(comment.content)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(comment.content),
                  ),
          ),
        ),
      ],
    );
  }
}

class ReplyComment extends StatelessWidget {
  final Reply reply;

  ReplyComment({required this.reply});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                child: SvgPicture.network(
                  reply.imageURL,
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: ListTile(
                trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border_rounded)),
                dense: true,
                title: Text(
                  reply.userName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: reply.type == "text"
                    ? Text(reply.content)
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(reply.content),
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Comment {
  final String userName;
  final String imageURL;
  final String content;
  final String type;
  final String id;
  final List<Reply> replies;

  Comment({
    required this.userName,
    required this.imageURL,
    required this.content,
    required this.type,
    required this.id,
    List<Reply>? replies,
  }) : this.replies = replies ?? [];
}

class Reply {
  final String userName;
  final String imageURL;
  final String content;
  final String type;
  final String id;

  Reply({
    required this.userName,
    required this.imageURL,
    required this.content,
    required this.type,
    required this.id,
  });
}

class Articles {
  String _author, _title, _description, _image, _publishAt;

  Articles(this._author, this._title, this._description, this._image,
      this._publishAt);

  String get author => _author;

  set author(String value) {
    _author = value;
  }

  get title => _title;

  get publishAt => _publishAt;

  set publishAt(value) {
    _publishAt = value;
  }

  get image => _image;

  set image(value) {
    _image = value;
  }

  get description => _description;

  set description(value) {
    _description = value;
  }

  set title(value) {
    _title = value;
  }

  Articles.fromJson(Map<String, dynamic> map) {
    this._author=map['author'];
    this._description=map['description'];
    this._image=map['urlToImage'];
    this._title=map['title'];
    this.publishAt=map['publishedAt'];
  }
}

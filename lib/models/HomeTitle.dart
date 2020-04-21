class HomeTitle{
  String _titleAr,_titleEn;

  HomeTitle(this._titleEn,this._titleAr);

  get titleEn => _titleEn;

  set titleEn(value) {
    _titleEn = value;
  }

  String get titleAr => _titleAr;

  set titleAr(String value) {
    _titleAr = value;
  }


}
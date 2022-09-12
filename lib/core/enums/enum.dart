enum ApiMethod { get, post, put, delete }

enum MessageFileTypes { gorsel, seskaydi, video, test, text }

/* public enum MessageFileTypes
    {
        [Display(Name = "Görsel")]
        Image = 1,
        [Display(Name = "Ses Kaydı")]
        Sound = 2,
        [Display(Name = "Video")]
        Video = 3,
        [Display(Name = "Test")]
        Test = 4,
    } */

enum MessagePosition { R, L }

//position = L veya R gelir. R olanlar kişinin kendi gönderdikleri, L ise diğerlerinin mesajları.

enum AvailabilityStatus { available, notAvailable, appointment }

String? getFileTypeText(MessageFileTypes? fileType) {
  String? f;
  if (fileType != null) {
    switch (fileType) {
      case MessageFileTypes.gorsel:
        f = 'Görsel';
        break;
      case MessageFileTypes.seskaydi:
        f = 'Ses Kaydı';
        break;
      case MessageFileTypes.video:
        f = 'Video';
        break;
      case MessageFileTypes.test:
        f = 'Test';
        break;
      case MessageFileTypes.text:
        f = null;
        break;
    }
  }

  return f;
}

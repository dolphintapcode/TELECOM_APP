import 'package:flutter/material.dart';

@immutable
class PolicySection {
  const PolicySection({
    required this.title,
    required this.content,
  });

  final String title;
  final String content;
}

@immutable
class FaqItem {
  const FaqItem({
    required this.question,
    required this.answer,
  });

  final String question;
  final String answer;
}

class MenuContent {
  const MenuContent._();

  static const List<PolicySection> appTerms = [
    PolicySection(
      title: '1. Điều khoản chung',
      content:
          'Bằng cách truy cập và sử dụng ứng dụng này, bạn đồng ý tuân thủ các điều khoản và điều kiện sử dụng. Nếu bạn không đồng ý với bất kỳ phần nào của các điều khoản này, vui lòng ngừng sử dụng ứng dụng ngay lập tức.',
    ),
    PolicySection(
      title: '2. Quyền sở hữu',
      content:
          'Ứng dụng này và tất cả nội dung, bao gồm nhưng không giới hạn ở văn bản, hình ảnh, đồ họa, biểu tượng và các tài liệu khác, đều thuộc sở hữu của đơn vị cung cấp dịch vụ hoặc các bên được cấp phép hợp pháp.',
    ),
    PolicySection(
      title: '3. Sử dụng hợp pháp',
      content:
          'Người dùng cam kết sử dụng ứng dụng này theo đúng các quy định pháp luật hiện hành và không được sử dụng ứng dụng vào mục đích bất hợp pháp, gian lận hoặc có thể gây ảnh hưởng xấu đến hệ thống hay người dùng khác.',
    ),
    PolicySection(
      title: '4. Quyền và nghĩa vụ của người dùng',
      content:
          'Người dùng có quyền truy cập và sử dụng các chức năng của ứng dụng theo đúng mục đích của nó. Người dùng phải tự chịu trách nhiệm về tính chính xác của thông tin mà họ cung cấp trong quá trình sử dụng ứng dụng.',
    ),
  ];

  static const List<PolicySection> privacyPolicy = [
    PolicySection(
      title: '1. Điều khoản chung',
      content:
          'Chính sách này mô tả cách ứng dụng thu thập, sử dụng và bảo vệ dữ liệu cá nhân của người dùng nhằm đảm bảo tính minh bạch và an toàn trong quá trình cung cấp dịch vụ.',
    ),
    PolicySection(
      title: '2. Dữ liệu được thu thập',
      content:
          'Chúng tôi có thể thu thập các thông tin như số điện thoại, email, thông tin tài khoản, lịch sử giao dịch và dữ liệu sử dụng ứng dụng để phục vụ cho việc xác thực, hỗ trợ và cải thiện trải nghiệm người dùng.',
    ),
    PolicySection(
      title: '3. Mục đích sử dụng dữ liệu',
      content:
          'Dữ liệu cá nhân được sử dụng để cung cấp dịch vụ, xử lý giao dịch, chăm sóc khách hàng, gửi thông báo quan trọng và nâng cao chất lượng sản phẩm. Chúng tôi không sử dụng dữ liệu ngoài các mục đích đã công bố nếu chưa có sự đồng ý của người dùng.',
    ),
    PolicySection(
      title: '4. Quyền của người dùng',
      content:
          'Người dùng có quyền yêu cầu xem, cập nhật hoặc chỉnh sửa dữ liệu cá nhân của mình. Trong một số trường hợp theo quy định pháp luật, người dùng cũng có thể yêu cầu hạn chế hoặc chấm dứt việc xử lý dữ liệu.',
    ),
  ];

  static const List<FaqItem> faqs = [
    FaqItem(
      question: '1. Làm thế nào để đăng ký tài khoản mới trên ứng dụng?',
      answer:
          'Tại màn hình đăng nhập, chọn mục "Đăng ký" và điền đầy đủ thông tin như số điện thoại, mật khẩu và mã OTP xác thực để hoàn tất.',
    ),
    FaqItem(
      question: '2. Làm sao tôi có thể thay đổi mật khẩu của mình?',
      answer:
          'Bạn vào phần đăng nhập, chọn "Quên mật khẩu" hoặc cập nhật trong phần thông tin tài khoản nếu đang đăng nhập. Hệ thống sẽ yêu cầu xác thực bằng OTP.',
    ),
    FaqItem(
      question: '3. Ứng dụng có hỗ trợ nhiều ngôn ngữ không?',
      answer:
          'Hiện tại ứng dụng đang hỗ trợ giao diện tiếng Việt. Các gói ngôn ngữ khác sẽ được bổ sung trong các phiên bản tiếp theo.',
    ),
    FaqItem(
      question: '4. Tôi có thể theo dõi đơn hàng của mình ở đâu?',
      answer:
          'Bạn có thể theo dõi giao dịch và lịch sử mua gói tại mục "Lịch sử" ngay trên thanh điều hướng chính của ứng dụng.',
    ),
    FaqItem(
      question: '5. Ứng dụng có cung cấp dịch vụ hỗ trợ trực tuyến không?',
      answer:
          'Có. Bạn có thể liên hệ qua tổng đài, email hoặc truy cập mục "Liên hệ với chúng tôi" để nhận hỗ trợ từ đội ngũ chăm sóc khách hàng.',
    ),
    FaqItem(
      question: '6. Làm thế nào để thêm sản phẩm vào giỏ hàng?',
      answer:
          'Với các gói cước hoặc quà tặng khả dụng, bạn chỉ cần chọn sản phẩm, xem chi tiết và xác nhận giao dịch theo hướng dẫn trên màn hình.',
    ),
    FaqItem(
      question: '7. Tôi có thể lưu sản phẩm yêu thích ở đâu?',
      answer:
          'Phiên bản hiện tại chưa có danh sách yêu thích riêng. Bạn có thể xem lại các gói đã quan tâm trong lịch sử thao tác hoặc banner gợi ý trên trang chủ.',
    ),
  ];

  static const String hotline = '1900 1024';
  static const String email = 'info@dataon.vn';
}

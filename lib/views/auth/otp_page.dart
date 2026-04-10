import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pinput/pinput.dart';
import 'package:telecom_app/views/widgets/custom_button.dart';
import '../../../core/themes/app_colors.dart';
import 'otp_provider.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  final bool isRegister;
  final String? displayName; // 🎯 Thêm biến này để nhận tên từ màn Register

  const OtpPage({
    super.key,
    required this.phoneNumber,
    this.isRegister = false,
    this.displayName, // Nhận tên người dùng
  });

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OtpProvider>().startResendTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final otpVM = context.watch<OtpProvider>();

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[50]!,
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primary, width: 2),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Text(
                'Xác thực mã OTP',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    height: 1.5,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Nhập mã xác thực gồm 6 chữ số được gửi về ',
                    ),
                    TextSpan(
                      text: '+84 ${widget.phoneNumber}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: ' qua tin nhắn.'),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              Pinput(
                length: 6,
                controller: pinController,
                autofocus: true,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                // Tự động cập nhật nút bấm khi nhập liệu
                onChanged: (pin) => setState(() {}),
                onCompleted: (pin) {
                  // 🎯 LUỒNG ĐĂNG NHẬP: Tự động xác thực khi đủ 6 số
                  if (!widget.isRegister) {
                    otpVM.verifyOtp(
                      context,
                      pin,
                      phoneNumber: widget.phoneNumber,
                      isRegister: false,
                    );
                  }
                },
              ),

              const SizedBox(height: 30),
              if (otpVM.isLoading)
                const CircularProgressIndicator(color: AppColors.primary),

              const Spacer(),

              // 🎯 NÚT HOÀN TẤT ĐĂNG KÝ
              if (widget.isRegister)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: CustomButton(
                    text: 'HOÀN TẤT ĐĂNG KÝ',
                    // Nút sáng lên khi đã nhập đủ 6 số
                    onPressed:
                        pinController.text.length == 6 && !otpVM.isLoading
                        ? () => otpVM.verifyOtp(
                            context,
                            pinController.text,
                            phoneNumber: widget.phoneNumber,
                            displayName: widget
                                .displayName, // 🎯 Truyền tên để lưu Firebase
                            isRegister: true,
                          )
                        : null,
                  ),
                ),

              // Gửi lại mã
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Bạn không nhận được mã? "),
                  otpVM.resendSeconds > 0
                      ? Text(
                          "Gửi lại sau ${otpVM.resendSeconds}s",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : TextButton(
                          onPressed: () => otpVM.startResendTimer(),
                          child: const Text(
                            "Gửi lại",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:telecom_app/gen/assets.gen.dart';
import '../../widgets/custom_button.dart';
import 'login_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lắng nghe các thay đổi từ Provider
    final loginVM = context.watch<LoginProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF5F5F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Đăng nhập',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 231,
                width: 32,
              ), // Chỉnh lại khoảng cách cho cân đối
              // Ô nhập số điện thoại
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    _buildCountryPicker(context),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: loginVM.phoneController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          hintText: 'Nhập số điện thoại',
                          hintStyle: TextStyle(
                            color: const Color(0xffB0B0B0),
                            fontWeight: FontWeight.w400,
                          ),
                          errorText: loginVM.errorText,
                          border: InputBorder.none,
                        ),
                        onChanged: loginVM.onPhoneChanged,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Nút Tiếp tục
              if (loginVM.isLoading)
                const CircularProgressIndicator(color: Colors.red)
              else
                CustomButton(
                  text: 'Tiếp tục',
                  onPressed: () => loginVM.handleContinue(context),
                ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Widget con để chọn quốc gia (tách ra cho gọn build chính)
  Widget _buildCountryPicker(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => const SizedBox(
            height: 200,
            child: Center(child: Text('Danh sách quốc gia')),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Row(
          children: [
            Image.asset(
              Assets.icons.vn.path,
              height: 30,
              errorBuilder: (_, _, _) => const Icon(Icons.flag),
            ),
            const SizedBox(width: 4),
            const Text(
              '+84',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

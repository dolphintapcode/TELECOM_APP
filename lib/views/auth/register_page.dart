import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telecom_app/core/themes/app_colors.dart';
import 'package:telecom_app/gen/assets.gen.dart';
import '../../widgets/custom_button.dart';
import 'register_provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final registerVM = context.watch<RegisterProvider>();

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
          'Đăng ký',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // NHẬP SỐ ĐIỆN THOẠI
              _buildPhoneInput(context, registerVM),

              const SizedBox(height: 30),

              // NHẬP TÊN
              const Text(
                "Tên bạn là gì",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: TextField(
                  controller: registerVM.nameController,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Nhập họ và tên',
                    hintStyle: TextStyle(
                      color: const Color(0xffB0B0B0),
                      fontWeight: FontWeight.w400,
                    ),
                    errorText: registerVM.nameErrorText,
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  onChanged: registerVM.onNameChanged,
                ),
              ),

              const Spacer(),

              // ĐIỀU KHOẢN
              _buildTermsText(),

              const SizedBox(height: 16),

              // NÚT TIẾP TỤC
              if (registerVM.isLoading)
                const Center(
                  child: CircularProgressIndicator(color: Colors.red),
                )
              else
                CustomButton(
                  text: 'Tiếp tục',
                  onPressed: () => registerVM.handleRegister(context),
                ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneInput(BuildContext context, RegisterProvider vm) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        children: [
          _buildCountryCode(context),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: vm.phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Nhập số điện thoại',
                hintStyle: TextStyle(
                  color: const Color(0xffB0B0B0),
                  fontWeight: FontWeight.w400,
                ),
                errorText: vm.phoneErrorText,
                border: InputBorder.none,
              ),
              onChanged: vm.onPhoneChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountryCode(BuildContext context) {
    return InkWell(
      onTap: () {}, // Logic chọn quốc gia
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
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

  Widget _buildTermsText() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 12, color: Colors.grey, height: 1.5),
        children: [
          const TextSpan(
            text: 'Bằng việc đăng ký, bạn xác nhận rằng bạn đồng ý với ',
          ),
          TextSpan(
            text: 'Điều khoản và Điều kiện',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(text: ' của chúng tôi'),
        ],
      ),
    );
  }
}

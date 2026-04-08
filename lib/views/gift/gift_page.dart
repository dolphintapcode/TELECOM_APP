import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:telecom_app/core/utils/dialog_utils.dart';
import 'package:telecom_app/gen/assets.gen.dart';
import 'package:telecom_app/navigation/app_router.dart';
import 'package:telecom_app/views/gift/gift_provider.dart';
import 'package:telecom_app/views/home/package_model.dart';

class GiftPage extends StatefulWidget {
  final PackageModel package;
  const GiftPage({super.key, required this.package});

  @override
  State<GiftPage> createState() => _GiftPageState();
}

class _GiftPageState extends State<GiftPage> {
  @override
  void initState() {
    super.initState();
    // Reset dữ liệu khi vào trang
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GiftProvider>().clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final giftVM = context.watch<GiftProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Tặng gói cước",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _PackageCard(pkg: widget.package),
                  const SizedBox(height: 20),
                  _PhoneInput(vm: giftVM),
                  const SizedBox(height: 10),

                  const Text(
                    "Dịch vụ chỉ áp dụng cho thuê bao Viettel",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),

                  const SizedBox(height: 30),
                  const Text(
                    "Danh bạ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 16),

                  ...giftVM.filteredContacts.map(
                    (contact) => _ContactItem(vm: giftVM, contact: contact),
                  ),
                ],
              ),
            ),
          ),

          // 🎯 PHẦN NÚT BẤM DƯỚI ĐÁY
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRouter.contactPicker);
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 54),
                        side: const BorderSide(color: Color(0xFFEE4D2D)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: SvgPicture.asset(
                        Assets.icons.danhB,
                        width: 20,
                        height: 20,
                      ),
                      label: const Text(
                        "Tìm trong danh bạ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFEE4D2D),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 4,
                    child: ElevatedButton(
                      onPressed: giftVM.isValid
                          ? () {
                              // 🎯 GỌI HÀM TỪ FILE DÙNG CHUNG Ở ĐÂY
                              DialogUtils.showPackageConfirmDialog(
                                context,
                                package: widget.package,
                                type: TransactionType.gift,
                                recipientPhone: giftVM.phoneController.text,
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEE4D2D),
                        disabledBackgroundColor: Colors.grey.shade300,
                        minimumSize: const Size(0, 54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Tiếp tục",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, {bool isRed = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isRed ? Colors.red : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- CÁC CLASS PRIVATE GIỮ NGUYÊN (NHƯ ÔNG ĐÃ VIẾT) ---
class _PackageCard extends StatelessWidget {
  final PackageModel pkg;
  const _PackageCard({required this.pkg});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: pkg.image.image(width: 48, height: 48, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pkg.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "${pkg.duration} • ${pkg.description}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),
          Text(
            pkg.price,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _PhoneInput extends StatelessWidget {
  final GiftProvider vm;
  const _PhoneInput({required this.vm});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: vm.phoneController,
      onChanged: vm.checkValidation,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: "Nhập số điện thoại người nhận",
        hintStyle: TextStyle(color: Color(0xFFB0B0B0), fontSize: 20),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final GiftProvider vm;
  final dynamic contact;
  const _ContactItem({required this.vm, required this.contact});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => vm.selectContact(contact),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: const Color(0xFFF0F0F0),
              child: Text(
                contact.name[0],
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  contact.phone,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

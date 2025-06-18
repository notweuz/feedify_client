import 'package:feedify/repositories/user/models/user_dto.dart';
import 'package:flutter/material.dart';

class NavigationBarUserAvatar extends StatelessWidget {
  final UserDTO userDTO;
  final double size;
  final bool isSelected;

  const NavigationBarUserAvatar({
    super.key,
    required this.userDTO,
    required this.size,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final icon = isSelected ? Icons.person : Icons.person_outline;

    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: userDTO.avatarUrl != null && userDTO.avatarUrl!.isNotEmpty
            ? Stack(
                children: [
                  Image.network(
                    userDTO.avatarUrl!,
                    fit: BoxFit.cover,
                    width: size,
                    height: size,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(icon, size: size);
                    },
                  ),
                ],
              )
            : Icon(icon, size: size),
      ),
    );
  }
}

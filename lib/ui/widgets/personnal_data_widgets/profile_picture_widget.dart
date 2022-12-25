import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/business_logic/personal_data_cubit/personal_data_cubit.dart';
import 'package:shop/utils/app_constants.dart';
import 'package:shop/utils/app_palette.dart';
import 'package:shop/utils/dimensions.dart';

class ProfilePictureWidget extends StatelessWidget {
  ProfilePictureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalDataCubit, PersonalDataState>(
      builder: (context, state) {
        PersonalDataCubit personalDataCubit = PersonalDataCubit.get(context);
        return SizedBox(
          width: 95.w,
          height: 95.h,
          child: Stack(
            children: [
              SizedBox(
                  width: 95.w,
                  height: 95.h,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: personalDataCubit.profilePicture == null
                            ? DecorationImage(
                                image: CachedNetworkImageProvider(profileImage),
                                fit: BoxFit.cover)
                            : DecorationImage(
                                image: FileImage(
                                    personalDataCubit.profilePicture!),
                                fit: BoxFit.cover)),
                  )),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: (){
                    personalDataCubit.changeProfilePicture();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppPalette.white,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSmall),
                        boxShadow: const [
                          BoxShadow(
                            color: AppPalette.shadowColor2,
                            spreadRadius: 0.7,
                            blurRadius: 3,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ]),
                    padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                    child: const Icon(
                      Icons.edit,
                      color: AppPalette.primary,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

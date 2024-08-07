import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

// Slider Cubit
class SliderCubit extends Cubit<int> {
  SliderCubit() : super(0);

  void nextPage() {
    if (state < images.length - 1) {
      emit(state + 1);
    } else {
      emit(0);
    }
  }

  void previousPage() {
    if (state > 0) {
      emit(state - 1);
    } else {
      emit(images.length - 1);
    }
  }
}

// Slider Widget
class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  final SliderCubit sliderCubit = SliderCubit();
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _stopAutoSlide();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds:2), (_) {
      _currentPage = (_currentPage + 1) % images.length;
      sliderCubit.emit(_currentPage);
    });
  }

  void _stopAutoSlide() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderCubit, int>(
      bloc: sliderCubit,
      builder: (context, state) {
        return GestureDetector(
          onHorizontalDragEnd: (details) {
            _stopAutoSlide();
            if (details.primaryVelocity! > 0) {
              sliderCubit.previousPage();
            } else if (details.primaryVelocity! < 0) {
              sliderCubit.nextPage();
            }
            _startAutoSlide();
          },
          child: Stack(
            children: [
              PageView.builder(
                itemCount: images.length,
                controller: PageController(initialPage: state),
                onPageChanged: (page) => sliderCubit.emit(page),
                itemBuilder: (context, pagePosition) {
                  final double value = pagePosition.toDouble() - state.toDouble();
                  final double opacity = value.abs().clamp(0.0, 1.0);
                  final double scale = 1.0 - opacity * 0.2;

                  return Opacity(
                    opacity: 1.0 - opacity,
                    child: Transform.scale(
                      scale: scale,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: CachedNetworkImage(
                          imageUrl: images[pagePosition],
                          fit: BoxFit.fill,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(images.length, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == state ? Colors.blue : Colors.grey,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

List<String> imagesFromAPI = [];
final List<String> images = imagesFromAPI;
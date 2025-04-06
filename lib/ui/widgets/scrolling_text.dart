import 'package:flutter/material.dart';

class ScrollingText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final double width;

  const ScrollingText({
    Key? key,
    required this.text,
    this.style,
    required this.width,
  }) : super(key: key);

  @override
  State<ScrollingText> createState() => _ScrollingTextState();
}

class _ScrollingTextState extends State<ScrollingText>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  AnimationController? _animationController;
  Animation<double>? _animation;
  final GlobalKey _contentKey = GlobalKey();
  bool _needsScroll = false;
  AnimationController? _fadeController;
  Animation<double>? _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _checkTextWidth();
  }

  @override
  void didUpdateWidget(ScrollingText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text || widget.width != oldWidget.width) {
      _resetAnimation();
      _checkTextWidth();
    }
  }

  void _checkTextWidth() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureContent();
    });
  }

  void _measureContent() {
    if (!mounted) return;

    final RenderBox? contentBox =
        _contentKey.currentContext?.findRenderObject() as RenderBox?;
    if (contentBox != null) {
      final contentWidth = contentBox.size.width;
      final needsScroll = contentWidth > widget.width;

      // 状態が変更された場合のみsetStateを呼び出す
      if (needsScroll != _needsScroll) {
        setState(() {
          _needsScroll = needsScroll;
        });
      }

      // 既存のアニメーションを適切にクリーンアップ
      _resetAnimation();

      // スクロールが必要な場合は新しいアニメーションをセットアップ
      if (needsScroll) {
        _setupAnimation(contentWidth);
      }
    }
  }

  void _setupAnimation(double contentWidth) {
    // スクロールアニメーションのセットアップ
    _animationController?.dispose();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (contentWidth * 15).toInt()),
    );

    // フェードアニメーションのセットアップ
    _fadeController?.dispose();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // フェードの時間
    );

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_fadeController!);

    final double distance = contentWidth - widget.width;
    _animation = Tween<double>(begin: 0, end: -distance).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.linear),
    );

    _animation!.addListener(() {
      if (_scrollController.hasClients) {
        if (_animation!.status == AnimationStatus.completed) {
          // アニメーション完了時の処理
          _handleAnimationComplete();
        } else {
          _scrollController.jumpTo(-_animation!.value);
        }
      }
    });

    // アニメーションを開始
    _animationController!.forward();
  }

  Future<void> _handleAnimationComplete() async {
    await Future.delayed(const Duration(seconds: 2));
    await _fadeController!.forward();
    _scrollController.jumpTo(0);
    await _fadeController!.reverse();
    _animationController!.reset();
    _animationController!.forward();
  }

  void _resetAnimation() {
    if (_animationController != null) {
      _animationController!.stop();
      _animationController!.dispose();
      _animationController = null;
      _animation = null;
    }
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  @override
  void dispose() {
    _fadeController?.dispose();
    _resetAnimation();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: FadeTransition(
        opacity: _fadeAnimation ?? const AlwaysStoppedAnimation(1.0),
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            key: _contentKey,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(widget.text, style: widget.style),
          ),
        ),
      ),
    );
  }
}

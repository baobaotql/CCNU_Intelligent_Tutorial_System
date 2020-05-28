import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tutorial/models/data.dart';
import 'package:tutorial/views/chat_view.dart';

const double _kFlingVelocity = 2.0; //动画速度

class Backdrop extends StatefulWidget {
  final currentCategory;
  final String title;
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;

  const Backdrop({
    @required this.currentCategory,
    @required this.title,
    @required this.frontLayer,
    @required this.backLayer,
    @required this.frontTitle,
    @required this.backTitle,
  })  : assert(frontLayer != null),
        assert(backLayer != null),
        assert(frontTitle != null),
        assert(backTitle != null);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {

  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Add AnimationController widget (104)
  AnimationController _controller;

  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(
        velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Backdrop old) {
    super.didUpdateWidget(old);

    if (widget.currentCategory != old.currentCategory) {
      _toggleBackdropLayerVisibility();
    } else
      if (!_frontLayerVisible) {
      _controller.fling(velocity: _kFlingVelocity);
    }
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;
    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_controller.view);
    return Stack(
      key: _backdropKey,
      children: <Widget>[
        ExcludeSemantics(
          child: widget.backLayer,
          excluding: _frontLayerVisible,
        ),
        PositionedTransition(
            rect: layerAnimation,
            child: _FrontLayer(
              child: widget.frontLayer,
              onTap: _toggleBackdropLayerVisibility,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _toggleBackdropLayerVisibility,
          child: Container(
            width: 260,
              child: Center(child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 30,),
                  Text(widget.title),
                  SizedBox(width: 10,),
                  Icon(Icons.arrow_drop_down,size: 50.0,)
                ],
              )))
      ),
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: GestureDetector(
        onTap: (){
          Navigator.of(context).pop();
          DummyDataService.tempProblems = null;
        },
        child: Icon(Icons.arrow_back_ios,
        ),
      ),
    );

    bool _show = false;
    PersistentBottomSheetController sheetController;

    return Scaffold(
      key:  scaffoldKey,
      appBar: appBar,
      body: LayoutBuilder(
        builder: _buildStack,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.people_outline,color: Theme.of(context).primaryColor,),
          onPressed: () {
            if (!_show){
              _show = true;
              sheetController = scaffoldKey.currentState.showBottomSheet((context) =>
                 ChatView());
              sheetController.closed.then((value) {
                print('sheet closed');
                _show=false;
              });
            }else{
              sheetController.close();
              _show=false;
            }
          }
      ),
    );
  }
}

class _FrontLayer extends StatelessWidget {
  const _FrontLayer({Key key, this.child, this.onTap}) : super(key: key);

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      color: Theme.of(context).primaryColor,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(24.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: null,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
